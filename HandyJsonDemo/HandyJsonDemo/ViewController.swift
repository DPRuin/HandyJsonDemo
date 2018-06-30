//
//  ViewController.swift
//  HandyJsonDemo
//
//  Created by mac126 on 2018/6/23.
//  Copyright © 2018年 mac126. All rights reserved.
//

import UIKit
import HandyJSON

struct Sub3DModel: HandyJSON {
    var modelFileName: String?
    var animationFileName: String?
    var animationRootNode: String?
    var isMainObject: Bool?
}

class AnimationModel: HandyJSON {
    var name: String?
    var version: Int?
    var soundUrl: String?
    var imageUrl: String?
    var modelsDownloadUrl: String?
    var artModels: [Sub3DModel]?
    
    required init() {}
}

class AnimationGroupModel: HandyJSON {
    var version: Int?
    var animationGroupName: String?
    var animationModels: [AnimationModel]?
    
    required init() {}
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("\n--------------------- serilization ---------------------\n")
        self.serialization()
        print("\n--------------------- deserilization ---------------------\n")
        // self.deserialization()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func serialization() {
        // 组动画
        let animationGroupModel = AnimationGroupModel()
        animationGroupModel.version = 1
        animationGroupModel.animationGroupName = "panda"
        
        // cheers动画
        let animationCheer =  AnimationModel()
        animationCheer.name = "cheers"
        animationCheer.version = 1
        animationCheer.soundUrl = "https://newstest.cgtn.com/resource/ar/asset/cheering_audioonly.mp3"
        animationCheer.imageUrl = "https://newstest.cgtn.com/resource/ar/asset/cheer.png"
        animationCheer.modelsDownloadUrl = "https://newstest.cgtn.com/resource/ar/asset/cheers_panda.zip"
        
        // let cheers_panda = Sub3DModel(modelFileName: "cheers_panda", animationFileName: "cheers_panda_idle", animationRootNode: "Max_rootNode")
        
        let cheers_panda = Sub3DModel(modelFileName: "cheers_panda", animationFileName: "cheers_panda_idle", animationRootNode: "panda", isMainObject: true)
        
        let cheers_dust = Sub3DModel(modelFileName: "cheers_dust", animationFileName: "cheers_dust", animationRootNode: "dust", isMainObject: false)
        
        let cheers_shadow = Sub3DModel(modelFileName: "cheers_shadow", animationFileName: "cheers_shadow", animationRootNode: "shadow_jnt", isMainObject: false)
        
        animationCheer.artModels = [cheers_panda, cheers_dust, cheers_shadow]
        
        // moonwalk动画
        let animationMoonwalk =  AnimationModel()
        animationMoonwalk.name = "moonwalk"
        animationMoonwalk.version = 1
        animationMoonwalk.soundUrl = "https://newstest.cgtn.com/resource/ar/asset/moonwalk_audioonly.mp3"
        animationMoonwalk.imageUrl = "https://newstest.cgtn.com/resource/ar/asset/moonwalk.png"
        animationMoonwalk.modelsDownloadUrl = "https://newstest.cgtn.com/resource/ar/asset/moonwalk.zip"
        
        // let moonwalk_panda = Sub3DModel(modelFileName: nil, animationFileName: "moonwalk_panda", animationRootNode: "Max_rootNode")
        let moonwalk_panda = Sub3DModel(modelFileName: nil, animationFileName: "moonwalk_panda", animationRootNode: "panda", isMainObject: false)
        
        let moonwalk_glasses = Sub3DModel(modelFileName: "moonwalk_glasses", animationFileName: "moonwalk_glasses", animationRootNode: "glasses", isMainObject: false)
        let moonwalk_shadow = Sub3DModel(modelFileName: "moonwalk_shadow", animationFileName: "moonwalk_shadow", animationRootNode: "shadow_jnt", isMainObject: false)
        
        animationMoonwalk.artModels = [moonwalk_panda, moonwalk_glasses, moonwalk_shadow]
        
        
        
        animationGroupModel.animationModels = [animationCheer, animationMoonwalk]
        
        
        print([animationGroupModel].toJSONString(prettyPrint: true)!)
        
        // 保存为json文件
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentDirectoryUrl.appendingPathComponent("download.json")
        
        do {
            let data = try JSONSerialization.data(withJSONObject: [animationGroupModel].toJSON(), options: [])
            try data.write(to: fileUrl, options: [])
        } catch {
            print(error)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        deserialization()
    }
    
    func deserialization() {
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentDirectoryUrl.appendingPathComponent("download.json")
        
        do {
            let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! [Any]
            
            if let animationGroups = [AnimationGroupModel].deserialize(from: jsonResult) {
                print(animationGroups.count)
                print(animationGroups[0]!.toJSON()!)
                let anima = animationGroups[0]?.animationModels![0] as! AnimationModel
                let art = anima.artModels![0] as! Sub3DModel
                print("----\(art.modelFileName)")
            }
            
        } catch {
            // handle error
            print("errorhhhhhh")
        }
    }
}

