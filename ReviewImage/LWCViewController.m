//
//  LWCViewController.m
//  CustomMapDemo
//
//  Created by 李伟超 on 15/3/24.
//  Copyright (c) 2015年 LWC. All rights reserved.
//

#import "LWCViewController.h"
#import "Area.h"

@interface LWCViewController ()

@end

@implementation LWCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _fetchController = [[FetchController alloc] initWithEntity:@"Area" WithSortKey:@"a_id"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    _fetchController = nil;
    [_fetchController release];
    [super dealloc];
}

- (IBAction)ClickButton:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    if (button.tag == 0) {
        
        NSMutableArray *array = [NSMutableArray array];
        
        NSDictionary *dic1 = @{@"a_id":             @1,
                               @"a_name":           @"总工会",
                               @"a_organization":   @"总工会",
                               @"a_type":           @1,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @0,
                               @"a_originY":        @0,
                               @"a_endX":           @0,
                               @"a_endY":           @0,
                               };
        [array addObject:dic1];
        NSDictionary *dic2 = @{@"a_id":             @2,
                               @"a_name":           @"1",
                               @"a_organization":   @"总工会",
                               @"a_type":           @3,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @2480.0,
                               @"a_originY":        @1308.0,
                               @"a_endX":           @2535.0,
                               @"a_endY":           @1351.0,
                               };
        [array addObject:dic2];
        NSDictionary *dic3 = @{@"a_id":             @3,
                               @"a_name":           @"2",
                               @"a_organization":   @"总工会",
                               @"a_type":           @3,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @2480.0,
                               @"a_originY":        @1262.0,
                               @"a_endX":           @2535.0,
                               @"a_endY":           @1302.0,
                               };
        [array addObject:dic3];
        NSDictionary *dic4 = @{@"a_id":             @4,
                               @"a_name":           @"3",
                               @"a_organization":   @"总工会",
                               @"a_type":           @3,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @2480.0,
                               @"a_originY":        @1214.0,
                               @"a_endX":           @2535.0,
                               @"a_endY":           @1255.0,
                               };
        [array addObject:dic4];
        NSDictionary *dic5 = @{@"a_id":             @5,
                               @"a_name":           @"档案馆",
                               @"a_organization":   @"档案馆",
                               @"a_type":           @1,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @0,
                               @"a_originY":        @0,
                               @"a_endX":           @0,
                               @"a_endY":           @0,
                               };
        [array addObject:dic5];
        NSDictionary *dic6 = @{@"a_id":             @6,
                               @"a_name":           @"4",
                               @"a_organization":   @"档案馆",
                               @"a_type":           @3,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @2480.0,
                               @"a_originY":        @1168.0,
                               @"a_endX":           @2535.0,
                               @"a_endY":           @1207.0,
                               };
        [array addObject:dic6];
        NSDictionary *dic7 = @{@"a_id":             @7,
                               @"a_name":           @"5",
                               @"a_organization":   @"档案馆",
                               @"a_type":           @3,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @2480.0,
                               @"a_originY":        @1122.0,
                               @"a_endX":           @2535.0,
                               @"a_endY":           @1161.0,
                               };
        [array addObject:dic7];
        NSDictionary *dic8 = @{@"a_id":             @8,
                               @"a_name":           @"劳动能力鉴定中心",
                               @"a_organization":   @"劳动能力鉴定中心",
                               @"a_type":           @1,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @0,
                               @"a_originY":        @0,
                               @"a_endX":           @0,
                               @"a_endY":           @0,
                               };
        [array addObject:dic8];
        NSDictionary *dic9 = @{@"a_id":             @9,
                               @"a_name":           @"7",
                               @"a_organization":   @"劳动能力鉴定中心",
                               @"a_type":           @3,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @2480.0,
                               @"a_originY":        @1026.0,
                               @"a_endX":           @2535.0,
                               @"a_endY":           @1068.0,
                               };
        [array addObject:dic9];
        NSDictionary *dic10 = @{@"a_id":            @10,
                               @"a_name":           @"8",
                               @"a_organization":   @"劳动能力鉴定中心",
                               @"a_type":           @3,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @2480.0,
                               @"a_originY":        @984.0,
                               @"a_endX":           @2535.0,
                               @"a_endY":           @1021.0,
                               };
        [array addObject:dic10];
        NSDictionary *dic11 = @{@"a_id":            @11,
                               @"a_name":           @"9",
                               @"a_organization":   @"劳动能力鉴定中心",
                               @"a_type":           @3,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @2480.0,
                               @"a_originY":        @936.0,
                               @"a_endX":           @2535.0,
                               @"a_endY":           @977.0,
                               };
        [array addObject:dic11];
        NSDictionary *dic12 = @{@"a_id":            @12,
                               @"a_name":           @"10",
                               @"a_organization":   @"劳动能力鉴定中心",
                               @"a_type":           @3,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @2480.0,
                               @"a_originY":        @889.0,
                               @"a_endX":           @2535.0,
                               @"a_endY":           @929.0,
                               };
        [array addObject:dic12];
        NSDictionary *dic13 = @{@"a_id":            @13,
                               @"a_name":           @"11",
                               @"a_organization":   @"劳动能力鉴定中心",
                               @"a_type":           @3,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @2480.0,
                               @"a_originY":        @842.0,
                               @"a_endX":           @2535.0,
                               @"a_endY":           @883.0,
                               };
        [array addObject:dic13];
        NSDictionary *dic14 = @{@"a_id":            @14,
                               @"a_name":           @"农保中心",
                               @"a_organization":   @"农保中心",
                               @"a_type":           @1,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @0,
                               @"a_originY":        @0,
                               @"a_endX":           @0,
                               @"a_endY":           @0,
                               };
        [array addObject:dic14];
        NSDictionary *dic15 = @{@"a_id":             @15,
                                @"a_name":           @"14",
                                @"a_organization":   @"农保中心",
                                @"a_type":           @3,
                                @"a_number":         @"0",
                                @"a_floor":          @"L1",
                                @"a_originX":        @2480,
                                @"a_originY":        @704,
                                @"a_endX":           @2535,
                                @"a_endY":           @744,
                                };
        [array addObject:dic15];
        NSDictionary *dic16 = @{@"a_id":             @16,
                                @"a_name":           @"15",
                                @"a_organization":   @"农保中心",
                                @"a_type":           @3,
                                @"a_number":         @"0",
                                @"a_floor":          @"L1",
                                @"a_originX":        @2480,
                                @"a_originY":        @656,
                                @"a_endX":           @2535,
                                @"a_endY":           @696,
                                };
        [array addObject:dic16];
        NSDictionary *dic17 = @{@"a_id":             @17,
                                @"a_name":           @"16",
                                @"a_organization":   @"农保中心",
                                @"a_type":           @3,
                                @"a_number":         @"0",
                                @"a_floor":          @"L1",
                                @"a_originX":        @2480,
                                @"a_originY":        @608,
                                @"a_endX":           @2535,
                                @"a_endY":           @650,
                                };
        [array addObject:dic17];
        NSDictionary *dic18 = @{@"a_id":             @18,
                                @"a_name":           @"社保卡补换",
                                @"a_organization":   @"社保卡补换",
                                @"a_type":           @1,
                                @"a_number":         @"0",
                                @"a_floor":          @"L1",
                                @"a_originX":        @0,
                                @"a_originY":        @0,
                                @"a_endX":           @0,
                                @"a_endY":           @0,
                                };
        [array addObject:dic18];
        NSDictionary *dic19 = @{@"a_id":             @19,
                                @"a_name":           @"17",
                                @"a_organization":   @"社保卡补换",
                                @"a_type":           @3,
                                @"a_number":         @"0",
                                @"a_floor":          @"L1",
                                @"a_originX":        @2480,
                                @"a_originY":        @564,
                                @"a_endX":           @2535,
                                @"a_endY":           @604,
                                };
        [array addObject:dic19];
        NSDictionary *dic20 = @{@"a_id":             @20,
                                @"a_name":           @"18",
                                @"a_organization":   @"社保卡补换",
                                @"a_type":           @3,
                                @"a_number":         @"0",
                                @"a_floor":          @"L1",
                                @"a_originX":        @2480,
                                @"a_originY":        @518,
                                @"a_endX":           @2535,
                                @"a_endY":           @557,
                                    };
        [array addObject:dic20];
        NSDictionary *dic21 = @{@"a_id":             @21,
                                @"a_name":           @"科委",
                                @"a_organization":   @"科委",
                                @"a_type":           @1,
                                @"a_number":         @"0",
                                @"a_floor":          @"L1",
                                @"a_originX":        @0,
                                @"a_originY":        @0,
                                @"a_endX":           @0,
                                @"a_endY":           @0,
                                };
        [array addObject:dic21];
        NSDictionary *dic22 = @{@"a_id":             @22,
                                @"a_name":           @"19",
                                @"a_organization":   @"科委",
                                @"a_type":           @3,
                                @"a_number":         @"0",
                                @"a_floor":          @"L1",
                                @"a_originX":        @2480,
                                @"a_originY":        @469,
                                @"a_endX":           @2535,
                                @"a_endY":           @510,
                                };
        [array addObject:dic22];
        NSDictionary *dic23 = @{
                                @"a_id":             @23,
                                @"a_name":           @"外地劳动力管理所",
                                @"a_organization":   @"外地劳动力管理所",
                                @"a_type":           @1,
                                @"a_number":         @"0",
                                @"a_floor":          @"L1",
                                @"a_originX":        @0,
                                @"a_originY":        @0,
                                @"a_endX":           @0,
                                @"a_endY":           @0,
                                };
        [array addObject:dic23];
        NSDictionary *dic24 = @{@"a_id":             @24,
                                @"a_name":           @"20",
                                @"a_organization":   @"外地劳动力管理所",
                                @"a_type":           @3,
                                @"a_number":         @"0",
                                @"a_floor":          @"L1",
                                @"a_originX":        @2435,
                                @"a_originY":        @425,
                                @"a_endX":           @2480,
                                @"a_endY":           @470,
                                };
        [array addObject:dic24];
        NSDictionary *dic25 = @{@"a_id":           @25,
                              @"a_name":           @"21",
                              @"a_organization":   @"外地劳动力管理所",
                              @"a_type":           @3,
                              @"a_number":         @"0",
                              @"a_floor":          @"L1",
                              @"a_originX":        @2382,
                              @"a_originY":        @425,
                              @"a_endX":           @2425,
                              @"a_endY":           @470,
                              };
        [array addObject:dic25];
        NSDictionary *dic26 = @{@"a_id":           @26,
                              @"a_name":           @"22",
                              @"a_organization":   @"外地劳动力管理所",
                              @"a_type":           @3,
                              @"a_number":         @"0",
                              @"a_floor":          @"L1",
                              @"a_originX":        @2328,
                              @"a_originY":        @425,
                              @"a_endX":           @2372,
                              @"a_endY":           @470,
                              };
        [array addObject:dic26];
        NSDictionary *dic27 = @{@"a_id":           @27,
                              @"a_name":           @"23",
                              @"a_organization":   @"外地劳动力管理所",
                              @"a_type":           @3,
                              @"a_number":         @"0",
                              @"a_floor":          @"L1",
                              @"a_originX":        @2275,
                              @"a_originY":        @425,
                              @"a_endX":           @2318,
                              @"a_endY":           @470,
                              };
        [array addObject:dic27];
        NSDictionary *dic28 = @{@"a_id":           @28,
                              @"a_name":           @"24",
                              @"a_organization":   @"外地劳动力管理所",
                              @"a_type":           @3,
                              @"a_number":         @"0",
                              @"a_floor":          @"L1",
                              @"a_originX":        @2220,
                              @"a_originY":        @425,
                              @"a_endX":           @2265,
                              @"a_endY":           @470,
                              };
        [array addObject:dic28];
        NSDictionary *dic29 = @{@"a_id":           @29,
                              @"a_name":           @"人才服务中心",
                              @"a_organization":   @"人才服务中心",
                              @"a_type":           @1,
                              @"a_number":         @"0",
                              @"a_floor":          @"L1",
                              @"a_originX":        @0,
                              @"a_originY":        @0,
                              @"a_endX":           @0,
                              @"a_endY":           @0,
                              };
        [array addObject:dic29];
        NSDictionary *dic30 = @{@"a_id":           @30,
                              @"a_name":           @"25",
                              @"a_organization":   @"人才服务中心",
                              @"a_type":           @3,
                              @"a_number":         @"0",
                              @"a_floor":          @"L1",
                              @"a_originX":        @2167,
                              @"a_originY":        @425,
                              @"a_endX":           @2210,
                              @"a_endY":           @470,
                              };
        [array addObject:dic30];
        NSDictionary *dic31 = @{@"a_id":           @31,
                              @"a_name":           @"26",
                              @"a_organization":   @"人才服务中心",
                              @"a_type":           @3,
                              @"a_number":         @"0",
                              @"a_floor":          @"L1",
                              @"a_originX":        @2112,
                              @"a_originY":        @425,
                              @"a_endX":           @2157,
                              @"a_endY":           @470,
                              };
        [array addObject:dic31];
        NSDictionary *dic32 = @{@"a_id":           @32,
                              @"a_name":           @"27",
                              @"a_organization":   @"人才服务中心",
                              @"a_type":           @3,
                              @"a_number":         @"0",
                              @"a_floor":          @"L1",
                              @"a_originX":        @2058,
                              @"a_originY":        @425,
                              @"a_endX":           @2102,
                              @"a_endY":           @470,
                              };
        [array addObject:dic32];
        NSDictionary *dic33 = @{@"a_id":            @33,
                              @"a_name":           @"28",
                              @"a_organization":   @"人才服务中心",
                              @"a_type":           @3,
                              @"a_number":         @"0",
                              @"a_floor":          @"L1",
                              @"a_originX":        @2003,
                              @"a_originY":        @425,
                              @"a_endX":           @2048,
                              @"a_endY":           @470,
                              };
        [array addObject:dic33];
        NSDictionary *dic34 = @{@"a_id":           @34,
                              @"a_name":           @"29",
                              @"a_organization":   @"人才服务中心",
                              @"a_type":           @3,
                              @"a_number":         @"0",
                              @"a_floor":          @"L1",
                              @"a_originX":        @1950,
                              @"a_originY":        @425,
                              @"a_endX":           @1993,
                              @"a_endY":           @470,
                              };
        [array addObject:dic34];
        NSDictionary *dic35 = @{@"a_id":             @35,
                                @"a_name":           @"房产估价",
                                @"a_organization":   @"房产估价",
                                @"a_type":           @1,
                                @"a_number":         @"0",
                                @"a_floor":          @"L1",
                                @"a_originX":        @0,
                                @"a_originY":        @0,
                                @"a_endX":           @0,
                                @"a_endY":           @0,
                                };
        [array addObject:dic35];
        NSDictionary *dic36 = @{@"a_id":           @36,
                              @"a_name":           @"30",
                              @"a_organization":   @"房产估价",
                              @"a_type":           @3,
                              @"a_number":         @"0",
                              @"a_floor":          @"L1",
                              @"a_originX":        @1895,
                              @"a_originY":        @425,
                              @"a_endX":           @1940,
                              @"a_endY":           @470,
                              };
        [array addObject:dic36];
        NSDictionary *dic37 = @{@"a_id":           @37,
                              @"a_name":           @"31",
                              @"a_organization":   @"房产估价",
                              @"a_type":           @3,
                              @"a_number":         @"0",
                              @"a_floor":          @"L1",
                              @"a_originX":        @1842,
                              @"a_originY":        @425,
                              @"a_endX":           @1884,
                              @"a_endY":           @470,
                              };
        [array addObject:dic37];
        NSDictionary *dic38 = @{@"a_id":           @38,
                              @"a_name":           @"数字证书",
                              @"a_organization":   @"数字证书",
                              @"a_type":           @1,
                              @"a_number":         @"0",
                              @"a_floor":          @"L1",
                              @"a_originX":        @0,
                              @"a_originY":        @0,
                              @"a_endX":           @0,
                              @"a_endY":           @0,
                              };
        [array addObject:dic38];
        NSDictionary *dic39 = @{@"a_id":           @39,
                              @"a_name":           @"32",
                              @"a_organization":   @"数字证书",
                              @"a_type":           @3,
                              @"a_number":         @"0",
                              @"a_floor":          @"L1",
                              @"a_originX":        @1787,
                              @"a_originY":        @425,
                              @"a_endX":           @1830,
                              @"a_endY":           @470,
                              };
        [array addObject:dic39];
        NSDictionary *dic40 = @{@"a_id":             @40,
                              @"a_name":           @"33",
                              @"a_organization":   @"数字证书",
                              @"a_type":           @3,
                              @"a_number":         @"0",
                              @"a_floor":          @"L1",
                              @"a_originX":        @1732,
                              @"a_originY":        @425,
                              @"a_endX":           @1777,
                              @"a_endY":           @470,
                              };
        [array addObject:dic40];
        NSDictionary *dic41 = @{@"a_id":             @41,
                                @"a_name":           @"房产交易中心",
                                @"a_organization":   @"房产交易中心",
                                @"a_type":           @1,
                                @"a_number":         @"0",
                                @"a_floor":          @"L1",
                                @"a_originX":        @0,
                                @"a_originY":        @0,
                                @"a_endX":           @0,
                                @"a_endY":           @0,
                                };
        [array addObject:dic41];
        NSDictionary *dic42 = @{@"a_id":             @42,
                                @"a_name":           @"35",
                                @"a_organization":   @"房产交易中心",
                                @"a_type":           @3,
                                @"a_number":         @"0",
                                @"a_floor":          @"L1",
                                @"a_originX":        @1328,
                                @"a_originY":        @425,
                                @"a_endX":           @1374,
                                @"a_endY":           @470,
                                };
        [array addObject:dic42];
        NSDictionary *dic43 = @{@"a_id":             @43,
                               @"a_name":           @"36",
                               @"a_organization":   @"房产交易中心",
                               @"a_type":           @3,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @1266,
                               @"a_originY":        @425,
                               @"a_endX":           @1318,
                               @"a_endY":           @470,
                               };
        [array addObject:dic43];
        NSDictionary *dic44 = @{@"a_id":             @44,
                               @"a_name":           @"37",
                               @"a_organization":   @"房产交易中心",
                               @"a_type":           @3,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @1208,
                               @"a_originY":        @425,
                               @"a_endX":           @1258,
                               @"a_endY":           @470,
                               };
        [array addObject:dic44];
        NSDictionary *dic45 = @{@"a_id":             @45,
                               @"a_name":           @"38",
                               @"a_organization":   @"房产交易中心",
                               @"a_type":           @3,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @1148,
                               @"a_originY":        @425,
                               @"a_endX":           @1198,
                               @"a_endY":           @470,
                               };
        [array addObject:dic45];
        NSDictionary *dic46 = @{@"a_id":             @46,
                               @"a_name":           @"39",
                               @"a_organization":   @"房产交易中心",
                               @"a_type":           @3,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @1090,
                               @"a_originY":        @425,
                               @"a_endX":           @1140,
                               @"a_endY":           @470,
                               };
        [array addObject:dic46];
        NSDictionary *dic47 = @{@"a_id":             @47,
                               @"a_name":           @"40",
                               @"a_organization":   @"房产交易中心",
                               @"a_type":           @3,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @1030,
                               @"a_originY":        @425,
                               @"a_endX":           @1080,
                               @"a_endY":           @470,
                               };
        [array addObject:dic47];
        NSDictionary *dic48 = @{@"a_id":             @48,
                               @"a_name":           @"41",
                               @"a_organization":   @"房产交易中心",
                               @"a_type":           @3,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @976,
                               @"a_originY":        @425,
                               @"a_endX":           @1022,
                               @"a_endY":           @470,
                               };
        [array addObject:dic48];
        NSDictionary *dic49 = @{@"a_id":             @49,
                               @"a_name":           @"42",
                               @"a_organization":   @"房产交易中心",
                               @"a_type":           @3,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @916,
                               @"a_originY":        @425,
                               @"a_endX":           @964,
                               @"a_endY":           @470,
                               };
        [array addObject:dic49];
        NSDictionary *dic50 = @{@"a_id":             @50,
                               @"a_name":           @"43",
                               @"a_organization":   @"房产交易中心",
                               @"a_type":           @3,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @860,
                               @"a_originY":        @425,
                               @"a_endX":           @906,
                               @"a_endY":           @470,
                               };
        [array addObject:dic50];
        NSDictionary *dic51 = @{@"a_id":             @51,
                               @"a_name":           @"44",
                               @"a_organization":   @"房产交易中心",
                               @"a_type":           @3,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @800,
                               @"a_originY":        @425,
                               @"a_endX":           @848,
                               @"a_endY":           @470,
                               };
        [array addObject:dic51];
        NSDictionary *dic52 = @{@"a_id":             @52,
                               @"a_name":           @"45",
                               @"a_organization":   @"房产交易中心",
                               @"a_type":           @3,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @742,
                               @"a_originY":        @425,
                               @"a_endX":           @788,
                               @"a_endY":           @470,
                               };
        [array addObject:dic52];
        NSDictionary *dic53 = @{@"a_id":             @53,
                               @"a_name":           @"46",
                               @"a_organization":   @"房产交易中心",
                               @"a_type":           @3,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @686,
                               @"a_originY":        @425,
                               @"a_endX":           @726,
                               @"a_endY":           @470,
                               };
        [array addObject:dic53];
        NSDictionary *dic54 = @{@"a_id":             @54,
                                @"a_name":           @"47",
                                @"a_organization":   @"房产交易中心",
                                @"a_type":           @3,
                                @"a_number":         @"0",
                                @"a_floor":          @"L1",
                                @"a_originX":        @624,
                                @"a_originY":        @468,
                                @"a_endX":           @676,
                                @"a_endY":           @508,
                                };
        [array addObject:dic54];
        NSDictionary *dic55 = @{@"a_id":            @55,
                               @"a_name":           @"48",
                               @"a_organization":   @"房产交易中心",
                               @"a_type":           @3,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @624,
                               @"a_originY":        @522,
                               @"a_endX":           @676,
                               @"a_endY":           @562,
                              };
        [array addObject:dic55];
        NSDictionary *dic56 = @{@"a_id":              @56,
                               @"a_name":           @"49",
                               @"a_organization":   @"房产交易中心",
                               @"a_type":           @3,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @624,
                               @"a_originY":        @576,
                               @"a_endX":           @676,
                               @"a_endY":           @622,
                               };
        [array addObject:dic56];
        NSDictionary *dic57 = @{@"a_id":              @57,
                               @"a_name":           @"50",
                               @"a_organization":   @"房产交易中心",
                               @"a_type":           @3,
                               @"a_number":         @"0",
                               @"a_floor":          @"L1",
                               @"a_originX":        @624,
                               @"a_originY":        @634,
                               @"a_endX":           @676,
                               @"a_endY":           @676,
                               };
        [array addObject:dic57];
        NSDictionary *dic58 = @{@"a_id":              @58,
                                @"a_name":           @"51",
                                @"a_organization":   @"房产交易中心",
                                @"a_type":           @3,
                                @"a_number":         @"0",
                                @"a_floor":          @"L1",
                                @"a_originX":        @624,
                                @"a_originY":        @690,
                                @"a_endX":           @676,
                                @"a_endY":           @732,
                                };
        [array addObject:dic58];
        NSDictionary *dic59 = @{@"a_id":              @59,
                                @"a_name":           @"52",
                                @"a_organization":   @"房产交易中心",
                                @"a_type":           @3,
                                @"a_number":         @"0",
                                @"a_floor":          @"L1",
                                @"a_originX":        @624,
                                @"a_originY":        @744,
                                @"a_endX":           @676,
                                @"a_endY":           @788,
                                };
        [array addObject:dic59];
        NSDictionary *dic60 = @{@"a_id":              @60,
                                @"a_name":           @"住房信息中心",
                                @"a_organization":   @"住房信息中心",
                                @"a_type":           @1,
                                @"a_number":         @"0",
                                @"a_floor":          @"L1",
                                @"a_originX":        @0,
                                @"a_originY":        @0,
                                @"a_endX":           @0,
                                @"a_endY":           @0,
                                };
        [array addObject:dic60];
        NSDictionary *dic61 = @{@"a_id":              @61,
                                @"a_name":           @"53",
                                @"a_organization":   @"住房信息中心",
                                @"a_type":           @3,
                                @"a_number":         @"0",
                                @"a_floor":          @"L1",
                                @"a_originX":        @624,
                                @"a_originY":        @800,
                                @"a_endX":           @676,
                                @"a_endY":           @840,
                                };
        [array addObject:dic61];
        NSDictionary *dic62 = @{@"a_id":              @62,
                                @"a_name":           @"车辆购置税",
                                @"a_organization":   @"车辆购置税",
                                @"a_type":           @1,
                                @"a_number":         @"0",
                                @"a_floor":          @"L1",
                                @"a_originX":        @624,
                                @"a_originY":        @0,
                                @"a_endX":           @676,
                                @"a_endY":           @0,
                                };
        [array addObject:dic62];
        NSDictionary *dic63 = @{@"a_id":              @63,
                                @"a_name":           @"54",
                                @"a_organization":   @"车辆购置税",
                                @"a_type":           @3,
                                @"a_number":         @"0",
                                @"a_floor":          @"L1",
                                @"a_originX":        @624,
                                @"a_originY":        @856,
                                @"a_endX":           @676,
                                @"a_endY":           @896,
                                };
        [array addObject:dic63];
        NSDictionary *dic64 = @{@"a_id":              @64,
                                @"a_name":           @"房地产征税",
                                @"a_organization":   @"房地产征税",
                                @"a_type":           @1,
                                @"a_number":         @"0",
                                @"a_floor":          @"L1",
                                @"a_originX":        @0,
                                @"a_originY":        @0,
                                @"a_endX":           @0,
                                @"a_endY":           @0,
                                };
        [array addObject:dic64];
        NSDictionary *dic65 = @{@"a_id":              @65,
                                @"a_name":           @"55",
                                @"a_organization":   @"房地产征税",
                                @"a_type":           @3,
                                @"a_number":         @"0",
                                @"a_floor":          @"L1",
                                @"a_originX":        @624,
                                @"a_originY":        @908,
                                @"a_endX":           @676,
                                @"a_endY":           @952,
                                };
        [array addObject:dic65];
        NSDictionary *dic66 = @{@"a_id":              @66,
                                @"a_name":           @"56",
                                @"a_organization":   @"房地产征税",
                                @"a_type":           @3,
                                @"a_number":         @"0",
                                @"a_floor":          @"L1",
                                @"a_originX":        @624,
                                @"a_originY":        @964,
                                @"a_endX":           @676,
                                @"a_endY":           @1006,
                                };
        [array addObject:dic66];
        NSDictionary *dic67 = @{@"a_id":              @67,
                                @"a_name":           @"57",
                                @"a_organization":   @"房地产征税",
                                @"a_type":           @3,
                                @"a_number":         @"0",
                                @"a_floor":          @"L1",
                                @"a_originX":        @624,
                                @"a_originY":        @1020,
                                @"a_endX":           @676,
                                @"a_endY":           @1062,
                                };
        [array addObject:dic67];
        NSDictionary *dic68 = @{@"a_id":              @68,
                                @"a_name":           @"58",
                                @"a_organization":   @"房地产征税",
                                @"a_type":           @3,
                                @"a_number":         @"0",
                                @"a_floor":          @"L1",
                                @"a_originX":        @624,
                                @"a_originY":        @1074,
                                @"a_endX":           @676,
                                @"a_endY":           @1120,
                                };
        [array addObject:dic68];
        NSDictionary *dic69 = @{@"a_id":              @69,
                                @"a_name":           @"59",
                                @"a_organization":   @"房地产征税",
                                @"a_type":           @3,
                                @"a_number":         @"0",
                                @"a_floor":          @"L1",
                                @"a_originX":        @624,
                                @"a_originY":        @1134,
                                @"a_endX":           @676,
                                @"a_endY":           @1178,
                                };
        [array addObject:dic69];
        NSDictionary *dic70 = @{@"a_id":              @70,
                                @"a_name":           @"60",
                                @"a_organization":   @"房地产征税",
                                @"a_type":           @3,
                                @"a_number":         @"0",
                                @"a_floor":          @"L1",
                                @"a_originX":        @624,
                                @"a_originY":        @1188,
                                @"a_endX":           @676,
                                @"a_endY":           @1234,
                                };
        [array addObject:dic70];
        NSDictionary *dic71 = @{@"a_id":              @71,
                                @"a_name":           @"61",
                                @"a_organization":   @"房地产征税",
                                @"a_type":           @3,
                                @"a_number":         @"0",
                                @"a_floor":          @"L1",
                                @"a_originX":        @624,
                                @"a_originY":        @1246,
                                @"a_endX":           @676,
                                @"a_endY":           @1290,
                                };
        [array addObject:dic71];
        NSDictionary *dic72 = @{@"a_id":              @72,
                                @"a_name":           @"62",
                                @"a_organization":   @"房地产征税",
                                @"a_type":           @3,
                                @"a_number":         @"0",
                                @"a_floor":          @"L1",
                                @"a_originX":        @624,
                                @"a_originY":        @1304,
                                @"a_endX":           @676,
                                @"a_endY":           @1348,
                                };
        [array addObject:dic72];
//        NSDictionary *dic73 = @{@"a_id":              @73,
//                                @"a_name":           @"63",
//                                @"a_organization":   @"房地产征税",
//                                @"a_type":           @3,
//                                @"a_number":         @"0",
//                                @"a_floor":          @"L1",
//                                @"a_originX":        @0,
//                                @"a_originY":        @0,
//                                @"a_endX":           @0,
//                                @"a_endY":           @0,
//                                };
//        [array addObject:dic73];
        
        
        for (NSDictionary *dic in array) {
            Area *area = [NSEntityDescription insertNewObjectForEntityForName:@"Area" inManagedObjectContext:_fetchController.managedObjectContext];
            [area setValuesForKeysWithDictionary:dic];
        }
        
        //保存
        NSError *error = nil;
        if (![_fetchController.managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }else {
            NSLog(@"保存成功");
//            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Department"];
//            NSLog(@"%@",[_fetchController.managedObjectContext executeFetchRequest:fetchRequest error:&error]);
        }
    }else {
        /**
         *  方法一
         */
        
//        NSEntityDescription *entityDes = [NSEntityDescription entityForName:@"Department" inManagedObjectContext:_fetchController.managedObjectContext];
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dp_name = %@",@"婚姻（收养）登记中心"];
//        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//        [fetchRequest setEntity:entityDes];
//        [fetchRequest setPredicate:predicate];
//        NSError *error = nil;
//        NSArray *array = [_fetchController.managedObjectContext executeFetchRequest:fetchRequest error:&error];
//        
//        if (error) {
//            NSLog(@"%@",error);
//        }else {
//            NSLog(@"%@",array);
//            for (Department *department in array) {
//                NSSet *result = department.windows;
//                NSPredicate *filter = [NSPredicate predicateWithFormat:@"wd_name = %@",@"收养登记"];
//                
//                Window *window = [[result filteredSetUsingPredicate:filter] anyObject];
//                NSLog(@"%@",window.wd_name);
//            }
//
//        }
        
        
        /**
         *  方法二
         */
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Window"];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"wd_name like '收养登记'"];
        [fetchRequest setPredicate:predicate];
        NSError *error = nil;
        NSArray *array = [_fetchController.managedObjectContext executeFetchRequest:fetchRequest error:&error];
        [fetchRequest release];
//        NSEntityDescription *entityDes = [NSEntityDescription entityForName:@"Window" inManagedObjectContext:_fetchController.managedObjectContext];
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"wd_name like '收养登记'"];
//        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//        [fetchRequest setEntity:entityDes];
//        [fetchRequest setPredicate:predicate];
//        NSError *error = nil;
//        NSArray *array = [_fetchController.managedObjectContext executeFetchRequest:fetchRequest error:&error];
        
//        if (error) {
//            NSLog(@"%@",error);
//        }else {
//            NSLog(@"%@",array);
//            
//            NSPredicate *filter = [NSPredicate predicateWithFormat:@"dept.dp_name == '婚姻（收养）登记中心'"];
//            NSArray *resArr = [array filteredArrayUsingPredicate:filter];
//
//            for (Window *window in resArr) {
//                NSLog(@"%@",window.wd_name);
//            }
//            
//        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
