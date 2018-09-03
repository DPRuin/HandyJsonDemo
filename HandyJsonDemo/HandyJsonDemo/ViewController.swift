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
    var isAttachment: Bool?
}

class AnimationModel: HandyJSON {
    var name: String?
    var version: Int?
    var soundUrl: String?
    var soundMd5: String?
    
    var imageUrl: String?
    var modelsDownloadUrl: String?
    var modelsZipMd5: String?
    var modelsFilesMd5: Dictionary<String, String>?
    
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
        // 组
        let animationGroupModel = AnimationGroupModel()
        animationGroupModel.version = 1
        animationGroupModel.animationGroupName = "panda"
        
        // idle动画
        let animationIdle =  AnimationModel()
        animationIdle.name = "idle"
        animationIdle.version = 1
        animationIdle.soundUrl = "https://newstest.cgtn.com/resource/ar/asset/restingstate_audioonly.mp3"
        animationIdle.soundMd5 = "b21cd896bcea479c6dca8be518720fc7"
        animationIdle.imageUrl = "https://newstest.cgtn.com/resource/ar/asset/resting.png"
        animationIdle.modelsDownloadUrl = "https://newstest.cgtn.com/resource/ar/asset/resting.zip"
        animationIdle.modelsZipMd5 = "b5d449b14b8216679f1169172cf8c6c8"
        animationIdle.modelsFilesMd5 = [
            "resting_panda.scn" : "d1ff21182f143d9d42c49699d4585ec2",
            "dustAir.png" : "3698ce3b9e3290be62cb1654a656d021",
            "dustPuff.png" : "0dea749e38bd5d46fc1018a2c88d27ab",
            "glasses_color.png" : "18b7d9920bdd68a4072c6ac7d8db0a9a",
            "hearts.png" : "a167552ab20ef92370c246acc6719612",
            "panda_color.png" : "095c9f2164498b4c4b573e31022d57fd",
            "pandaShirt_color.png" : "f830f004aa07227fd2985a7aa638279d",
            "shadow.png" : "c392d7b81059a5c72ea962513d29d72b",
            "simShirt_color.png" : "1047a982337ef4f9ccc55b685a646b1f",
            "splode.png" : "eb41fff3164fc725f90287d457425063"
        ]
        
        let idle_panda = Sub3DModel(modelFileName: "resting_panda", animationFileName: "resting_panda", animationRootNode: "pandalocator1", isAttachment: false)
        animationIdle.artModels = [idle_panda]
        
        // moonwalk动画
        let animationMoonwalk =  AnimationModel()
        animationMoonwalk.name = "moonwalk"
        animationMoonwalk.version = 1
        animationMoonwalk.soundUrl = "https://newstest.cgtn.com/resource/ar/asset/moonwalk_audioonly.mp3"
        animationMoonwalk.imageUrl = "https://newstest.cgtn.com/resource/ar/asset/moonwalk.png"
        animationMoonwalk.modelsDownloadUrl = "https://newstest.cgtn.com/resource/ar/asset/moonwalk.zip"
        
        
        let moonwalk_panda = Sub3DModel(modelFileName: nil, animationFileName: "moonwalk_panda", animationRootNode: "panda", isAttachment: false)
        
        let moonwalk_glasses = Sub3DModel(modelFileName: "moonwalk_glasses", animationFileName: "moonwalk_glasses", animationRootNode: "glasses", isAttachment: true)
        let moonwalk_shadow = Sub3DModel(modelFileName: "moonwalk_shadow", animationFileName: "moonwalk_shadow", animationRootNode: "shadow_jnt", isAttachment: true)
        
        animationMoonwalk.artModels = [moonwalk_panda, moonwalk_glasses, moonwalk_shadow]
        
        // tshirt动画
        let animationTshirt =  AnimationModel()
        animationTshirt.name = "tshirt"
        animationTshirt.version = 1
        animationTshirt.soundUrl = "https://newstest.cgtn.com/resource/ar/asset/tshirt_audioonly.mp3"
        animationTshirt.imageUrl = "https://newstest.cgtn.com/resource/ar/asset/tshirt.png"
        animationTshirt.modelsDownloadUrl = "https://newstest.cgtn.com/resource/ar/asset/tshirt.zip"
        
        let tshirt_panda = Sub3DModel(modelFileName: nil, animationFileName: "tshirt_panda", animationRootNode: "pandalocator1", isAttachment: false)
        
        let tshirt_tshirt01 = Sub3DModel(modelFileName: "tshirt_tshirt01", animationFileName: "tshirt_tshirt01", animationRootNode: "pandalocator1", isAttachment: true)
        
        let tshirt_tshirt02 = Sub3DModel(modelFileName: "tshirt_tshirt02", animationFileName: "tshirt_tshirt02", animationRootNode: "pandalocator1", isAttachment: true)
        
        animationTshirt.artModels = [tshirt_panda, tshirt_tshirt01, tshirt_tshirt02]
        
        // cheers动画
        let animationCheer =  AnimationModel()
        animationCheer.name = "cheers"
        animationCheer.version = 1
        animationCheer.soundUrl = "https://newstest.cgtn.com/resource/ar/asset/cheering_audioonly.mp3"
        animationCheer.imageUrl = "https://newstest.cgtn.com/resource/ar/asset/cheer.png"
        animationCheer.modelsDownloadUrl = "https://newstest.cgtn.com/resource/ar/asset/cheers_panda.zip"

        let cheers_panda = Sub3DModel(modelFileName: nil, animationFileName: "cheers_panda", animationRootNode: "panda", isAttachment: false)
        
        let cheers_dust = Sub3DModel(modelFileName: "cheers_dust", animationFileName: "cheers_dust", animationRootNode: "dust", isAttachment: true)
        
        let cheers_shadow = Sub3DModel(modelFileName: "cheers_shadow", animationFileName: "cheers_shadow", animationRootNode: "shadow_jnt", isAttachment: true)
        
        animationCheer.artModels = [cheers_panda, cheers_dust, cheers_shadow]
        
        
        // hearts动画
        let animationHearts =  AnimationModel()
        animationHearts.name = "hearts"
        animationHearts.version = 1
        animationHearts.soundUrl = "https://newstest.cgtn.com/resource/ar/asset/hearts_audioonly.mp3"
        animationHearts.imageUrl = "https://newstest.cgtn.com/resource/ar/asset/hearts.png"
        animationHearts.modelsDownloadUrl = "https://newstest.cgtn.com/resource/ar/asset/hearts.zip"
        
        let hearts_panda = Sub3DModel(modelFileName: nil, animationFileName: "hearts_panda", animationRootNode: "pandalocator", isAttachment: false)
        
        let hearts_heart = Sub3DModel(modelFileName: "hearts_heart", animationFileName: "hearts_heart", animationRootNode: "pandalocator", isAttachment: true)
        
        let hearts_shadow = Sub3DModel(modelFileName: "hearts_shadow", animationFileName: "hearts_shadow", animationRootNode: "shadow_jnt", isAttachment: true)
        
        animationHearts.artModels = [hearts_panda, hearts_heart, hearts_shadow]
        
    
        animationGroupModel.animationModels = [animationIdle, animationMoonwalk, animationTshirt, animationCheer, animationHearts]
        
        
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

