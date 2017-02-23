//
//  trackswift
//  WGBB
//
//  Created by Zhongyi Yan on 5/21/16.
//  Copyright © 2016 Zhongyi Yan. All rights reserved.
//

import UIKit

//*****************************************************************
// Track struct
//*****************************************************************

struct Track {
	var title: String = ""
	var artist: String = ""
	var artworkURL: String = ""
	var artworkImage = UIImage(named: "albumArt")
	var artworkLoaded = false
	var isPlaying: Bool = false
}