Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9384613D91
	for <lists+netfilter-devel@lfdr.de>; Mon, 31 Oct 2022 19:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiJaSlp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 31 Oct 2022 14:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJaSlo (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:41:44 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130138.outbound.protection.outlook.com [40.107.13.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BB7DF77
        for <netfilter-devel@vger.kernel.org>; Mon, 31 Oct 2022 11:41:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwbxmyqAeqieXXzFgJvTvHleqv2zhGPuG3lvFYpT07d1lEWFH5SJ5WOLbU2LI2rcmknBPeVqU0QE/LYcHdWqcGqFh4CFSWPGOIJqUupwmzcJvCmT5K5oqrpx9+h1CrnnApRHOw1FB2I0QYJ2FPxW53M0HASeKF5alw+7Ej9rU0fBoWEZ+Mqwg4ewdlvsk61WwUPPvckqIOfd1LKdF+kLa4eLoO0CAt9Na2CGKhfWZ40CwLXnZqIA4aHwAoxeIom+frriMTtpObamXOlvo4Vp3YH3FkrozS9yYmFEtbD1bOHQTZ8m1QiDO3NSHX7m+G2jr7vB3Bvio5uJ+GNnpNWcgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObdasWzCx/tB3LT/JEbSMnzxG7G3fTkWzdQMSPXgnnA=;
 b=O0S3CpYPg8c60JUjWZUtGv/s5ULj3hMP7WcInxPUYkxw3YkZGGnxjaWmmEKtCuQbcH3F6cBRaYHSDfAGDJCpdSWyuPWRM4jR9WlFUL6WjL/8pJiaxzMVlGd4xquQnDGyCoFaw1OxgbXzLYDlzv13VVqsDjXRDnRZBv9T/5UYOaVbOEn6xCKq9wGPfBZLhqnOL/wxA6CpO6PU8nUO93MPl/s1C56riEFPNjhoxqWm0zwCLZ8MCA63QwQ7BAm5An2eLk+V2So+JciyRuSdJlyqMVwobZobSQrSENAzx21jB8mL0ZHHGgZJruR1Ah2BAUhEA6ORKIsZ+PZAxGSJQp5UPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObdasWzCx/tB3LT/JEbSMnzxG7G3fTkWzdQMSPXgnnA=;
 b=GfVnGnJIP4Rh9EQjn0DUJSKKGmSy4BpB00h4lZT07Tq2GUFU6r9DyMFpJT/fH81+fjwnjwMFDM+S/YITR9tpM2ghTDh4JFn0ahm+QMibMX/y36mLuYlrQsDKrdRJWOM/REn7tnapKaVbHgJZJbznrZcl8GVMM/vAM0wRxcIz1z0=
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by PR3P189MB0843.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:48::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.17; Mon, 31 Oct
 2022 18:41:37 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::9a8b:297a:91d9:67c8]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::9a8b:297a:91d9:67c8%7]) with mapi id 15.20.5791.017; Mon, 31 Oct 2022
 18:41:37 +0000
From:   Sriram Yagnaraman <sriram.yagnaraman@est.tech>
To:     Florian Westphal <fw@strlen.de>
CC:     "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        "claudio.porfiri@ericsson.com" <claudio.porfiri@ericsson.com>
Subject: Re: [PATCH v2 1/2] netfilter: conntrack: introduce no_random_port
 proc entry
Thread-Topic: [PATCH v2 1/2] netfilter: conntrack: introduce no_random_port
 proc entry
Thread-Index: AQHY7FrDQrsWkPaZuU67OW2UiNVkVq4oL7oAgACoXwA=
Date:   Mon, 31 Oct 2022 18:41:37 +0000
Message-ID: <7c24bfe4-94be-6eab-d30a-6dc0500652da@est.tech>
References: <20221030122541.31354-1-sriram.yagnaraman@est.tech>
 <20221030122541.31354-2-sriram.yagnaraman@est.tech>
 <20221031083858.GB5040@breakpoint.cc>
In-Reply-To: <20221031083858.GB5040@breakpoint.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBP189MB1433:EE_|PR3P189MB0843:EE_
x-ms-office365-filtering-correlation-id: f8441ab2-b964-42ec-1779-08dabb6f8ada
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9fnyvRxoBVWzyKKLw9C0uco0Xb/t4JFAtQkPO4RqYoMpvtH7zIvj6RahKQsCeZ0ia/k7zOvD1UDjFwmey96jWUzsI/P7N9A7WGSVpwpDpaQjKRCTJvyN+WVlufDLstx9R/96AAVZbY7chW+GNvBoRzwJBwy8AjpTgbZskk03ZISNM0q3OudQQo5taO8CX4r5Ee+QGODYzbwK8lrI9FE1g9Fm9+WaCn4EcbNRDIdfKszhKQBXfip7FpUk9ZtG5ykV5ZEmkdOdlrgI+X0Ly2t/8iLARrAu3dTqYF/K48Ueos7CWaOfVZnM6CEh/Wy5ouvpzG/N8SOjLD2LP5Jm+4ISQOiqgWL38lEcj06eIdTbn/9gQYqDyfovfJLX1m4+sztZKpZnAg1kuKonWj1mXeBnkEdeH13oJ+rU1aDb8WG7PW4VPHPrrPsJRbNlzghbpJXi8ZoVTCavcOPFSVVZBBV5pn9gZC3HkBsP/j88kvu4PF3ISoWR9JbCQY3HnbkYGO6Ec5BLKcmpRZuE2y5GoenGXNNlo1MI1+lQ+XmfZYiOaef0PdgRIUnqxVVEbprO8HqtiAArSorXzVS/bY5w8ZP7ojqTyD0ouI6UrRlzh7Ta2UWdyE+bTmH946wUs7TRQwXXqT3ilOr0u4EOk49shjCmIkwwUg9VpPMdaSnHkiXQhbxO3zIlRVDFm1oS4CzBzsdlquFdi2fMqKEGlgROwtsK6r5AfQF+MbNZ3TobtlXk98jfurMCZaJCXSRgrEJiV8U+QJnsdkyQ5cvALf2nzorP7Cy0X0FVMzcVoqcttOGb+XI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(39830400003)(136003)(346002)(366004)(376002)(396003)(451199015)(2616005)(44832011)(76116006)(38070700005)(186003)(6916009)(8676002)(4326008)(66946007)(66556008)(66476007)(64756008)(66446008)(6506007)(91956017)(54906003)(36756003)(5660300002)(316002)(6512007)(8936002)(26005)(86362001)(31696002)(53546011)(41300700001)(6486002)(83380400001)(122000001)(478600001)(31686004)(4001150100001)(71200400001)(38100700002)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODhLTWx4Z0JiK2dmYnFHOGRCSGFBT3hObElDYVFQa1dpelRPNjJlVTF1T1ow?=
 =?utf-8?B?SGlreVFYZmo0SzM5Rk1KVkZZa1Avcm50TkNQcmdDNnBTSDRFM1FvSjNKZGtr?=
 =?utf-8?B?THorZ0dzekYvcXBITEo5VXhZN2VMU0tKeFZ6b0x2UkQwWDE3VjRDOGFTMjFF?=
 =?utf-8?B?dUZ2ZHZRdnFwdVVWb00rQVA4THRqcVVGZWZjOHN5clllNXlMY3l2eXRCRnZj?=
 =?utf-8?B?OFB0dlR0UHp5T1daL2Y3Tnd4cm1UQ2dZVzdGL2xMY2N2VGIvTnp1MzA3bE1k?=
 =?utf-8?B?bVZZYkIxU0REWW5BZ1NrcnVQd0pSR2lDR240V29aaWVtK3pOdmExTXNRT3BB?=
 =?utf-8?B?UHg4WGNCN0wrM2ZpK2FVb25EQnhuYjVkTG1mNXpYY0NHOVVyRjlHK3lzS0Ny?=
 =?utf-8?B?RzR4K0E4YXNjTCsrdHJXSFNqZzlKY1JlaTJmM3V3cUxwWUdRR1NOK2lmYnQ2?=
 =?utf-8?B?Y3V1UGVXcTJZdzlpdFpCVFN0dnd6L2QvWEtoOG5CK3JCcFkzYW5TRHE4M053?=
 =?utf-8?B?YWRNalBpclBkQUcwNUJrOVVvaUVUeU1CUmdJNkhqSXA2cml2ajJObWNWY25Q?=
 =?utf-8?B?Rm5iT2dTb1BCSm5aK1RSUGcvMFBSRG9lNVJaN1FhUzA0RndkLzdia0F0SEJY?=
 =?utf-8?B?czFRN3dydyswVG5EV3k4QkNsdEwwWlJFUmRqUzQ4b0hvSG5ETmM0S0xFVVJX?=
 =?utf-8?B?eTBKQVBISU4xNjFWVVJDdE5OM20rNk8yZExCdi9NT3NvQlVjTkdJSERVQk1J?=
 =?utf-8?B?bkZSdnZzeWRJS2hmS1ZOMHQrL0l0NnR2c2p2OGtMVml0Q3B4d1VHRkJRMkNp?=
 =?utf-8?B?Q2ZWbHZ2SDNQaGhadXIxUFJqTnVTendoSTBkdUhMSkp4OUwwazdxMzJnWHht?=
 =?utf-8?B?ZVYrZTJzRmpyalNQQTRoblo0UlR2R3pJRW1yZmp6Z2ZwVnhybE9SeXVQNW05?=
 =?utf-8?B?SkdXc0ZmRW03SU0rNWZUTStGdjlVRC9WY0lrUUE2T3pkVXNMalJLNUdVZyta?=
 =?utf-8?B?cTYza0hVMlJxNVJkeTZiVnVWaytsNEJ6ZjVjZ0l6QjRXVVZvK0hkdERSTjBB?=
 =?utf-8?B?MWpJRDBoODk4RXpwOXo2a3pZVlFEMllTY0pPdHMxc0M3SmRYLzVzNXdwRFVB?=
 =?utf-8?B?VEIyaVVnVVk5SWpGVnJCTWtiQ1NvK0pVZVdvQVI4MnVacGZrTUZ2c2pvMXo1?=
 =?utf-8?B?d3RobzRZT25GV0c3MEFlSzU3YXNxQ05rZnVST3gxcjdNUC9PdFgrTmVFUlZG?=
 =?utf-8?B?enVMczVSU1ZXNUMrOVJGYWxTY0RUb2N0WXlFSUo1cnhKakZ5bXQxN0FkM1RG?=
 =?utf-8?B?aitZQ0hDZU9aQ0dWTWlzK2NZZEQ0ckJhZ0pidlNUZ1BIakpTYjdtR2RJK25w?=
 =?utf-8?B?UnJRNDEvRm05TTBRV21kWjBRZGNTaXhBaVl0V0RVdDNDMnY3dEpGNGJxTGhN?=
 =?utf-8?B?RGNlZ1Zqdk8vak8zYXVURW5NcU5JdTRrak8zSCt2aFBxUlA1TWJ2aFZwdlda?=
 =?utf-8?B?Y1BoakQ5RmtOT0lkL0loYk91Z1l0akhoUk9Cd3BWaUNhSENyajhjdFRGTlBQ?=
 =?utf-8?B?dDFNcDVkZkRFN1NrYkE1Z2xIaWpTbEtNWWxKTFdwTEtML1F2WTBuOHljTThI?=
 =?utf-8?B?anBxQ0xWdTZmMUg1Y3dIeEFDalFhQUxiZGJqMy9DTTVIV3daNmJleE9TNjBz?=
 =?utf-8?B?c0pTd0paU25Pay8wU0dpQ2pjY25LU243djczYko5TnJ4T2I4VlZZZ0tveVlZ?=
 =?utf-8?B?N1N2K1BEUGpPdlMwYU14RFlRSUZZVFIzNFJvVDFIWEFEeFBrRlJjOHF6OStL?=
 =?utf-8?B?bS9qSkRDanBuUVluTS9zME1sc3dyVkJKTFVqb3RYSlZvSUVoL050V1c5dkJ2?=
 =?utf-8?B?Y0tvTW54d2s0YTJXTDBUVnN0b1FhTXIvd1A4ZCtEbm5vWTJYYXRLSWg2bldC?=
 =?utf-8?B?Nmc4OVphUHlDNk8wSUFoOVM0UWJ6ZEkxalpveGhva1JHeXVEaWtsSDdNcjBD?=
 =?utf-8?B?YTY3RGY5OEtLbWJhTnFVTU5CejhBZWZJSnNZZ3lZRVVCQ2QwMC96dUF2OHRt?=
 =?utf-8?B?YXI5SHpRVE1ZSzg3OVg5RkdJbEtmanRTUEdrbHJvNjZ3R25vVTlUK3hCNGZh?=
 =?utf-8?Q?6nQlmV0nDTl/kD9lQuvzi1DWl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <067CB31EF766E54DBC55ECC0078B8012@EURP189.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f8441ab2-b964-42ec-1779-08dabb6f8ada
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 18:41:37.1034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eV5unAngn7qvTD9d28dsjTGczQAiE9ZxyxJbEUjLBaBh24OcORKynr2aisXiXTmWoNxlP4AjLfDhFa6R8CnQ8lxbBp8TSjXd8zWHasLd/VY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P189MB0843
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

T24gMjAyMi0xMC0zMSAwOTozOCwgRmxvcmlhbiBXZXN0cGhhbCB3cm90ZToNCg0KPiBzcmlyYW0u
eWFnbmFyYW1hbkBlc3QudGVjaCA8c3JpcmFtLnlhZ25hcmFtYW5AZXN0LnRlY2g+IHdyb3RlOg0K
Pj4gRnJvbTogU3JpcmFtIFlhZ25hcmFtYW4gPHNyaXJhbS55YWduYXJhbWFuQGVzdC50ZWNoPg0K
Pj4NCj4+IFRoaXMgcGF0Y2ggaW50cm9kdWNlcyBhIG5ldyBwcm9jIGVudHJ5IHRvIGRpc2FibGUg
c291cmNlIHBvcnQNCj4+IHJhbmRvbWl6YXRpb24gZm9yIFNDVFAgY29ubmVjdGlvbnMuDQo+IEht
bS4gIENhbiB5b3UgZWxhYm9yYXRlPyAgVGhlIHNwb3J0IGlzIG5ldmVyIHJhbmRvbWl6ZWQsIHVu
bGVzcyBlaXRoZXINCj4gMS4gVXNlciBleHBsaWNpdGx5IHJlcXVlc3RlZCBpdCB2aWEgInJhbmRv
bSIgZmxhZyBwYXNzZWQgdG8gc25hdCBydWxlLCBvcg0KPiAyLiB0aGUgaXMgYW4gZXhpc3Rpbmcg
Y29ubmVjdGlvbiwgdXNpbmcgdGhlICpzYW1lKiBzcG9ydDpzYWRkciAtPiBkYWRkcjpkcG9ydA0K
PiAgICBxdWFkcnVwbGUgYXMgdGhlIG5ldyByZXF1ZXN0Lg0KPg0KPiBJbiAyKSwgdGhpcyBuZXcg
dG9nZ2xlIHByZXZlbnRzIGNvbW11bmljYXRpb24uICBTbyBJIHdvbmRlciB3aHkgLi4uDQoNClRo
YW5rIHlvdSBzbyBtdWNoIGZvciB0aGUgZGV0YWlsZWQgcmV2aWV3IGNvbW1lbnRzLg0KDQpNeSB1
c2UgY2FzZSBmb3IgdGhpcyBmbGFnIG9yaWdpbmF0ZXMgZnJvbSBhIGRlcGxveW1lbnQgb2YgU0NU
UCBjbGllbnQNCmVuZHBvaW50cyBvbiBkb2NrZXIva3ViZXJuZXRlcyBlbnZpcm9ubWVudHMsIHdo
ZXJlIHR5cGljYWxseSB0aGVyZSBleGlzdHMNClNOQVQgcnVsZXMgZm9yIHRoZSBlbmRwb2ludHMg
b24gZWdyZXNzLiBUaGUgKnVzZXIqIGluIHRoaXMgY2FzZSBhcmUgdGhlDQpDTkkgcGx1Z2lucyB0
aGF0IGNvbmZpZ3VyZSB0aGUgU05BVCBydWxlcywgYW5kIHNvbWUgb2YgdGhlIG1vc3QgY29tbW9u
DQpwbHVnaW5zIHVzZSAtLXJhbmRvbS1mdWxseSByZWdhcmRsZXNzIG9mIHRoZSBwcm90b2NvbC4N
Cg0KQ29uc2lkZXIgYW4gU0NUUCBhc3NvY2lhdGlvbiBBIC0+IEIsIHdoaWNoIGhhcyB0d28gcGF0
aHMgdmlhIE5BVCBBIGFuZCBCDQpBOiAxLjIuMy40OjEyMzQ1DQpCOiA1LjYuNy44Lzk6NDINCk5B
VCBBOiAxLjIuMzEuNCAodXNlZCBmb3IgcGF0aCB0b3dhcmRzIDUuNi43LjgpDQpOQVQgQjogMS4y
LjMyLjQgKHVzZWQgZm9yIHBhdGggdG93YXJkcyA1LjYuNy45KQ0KDQogICAgICAgICAgICAgIOKU
jOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUkCAgIOKUjOKUgOKUgOKUgOKUkA0KICAgICAgICAgICDi
lIzilIDilIDilrogTkFUIEEg4pSc4pSA4pSA4pSA4pa6ICAg4pSCDQog4pSM4pSA4pSA4pSA4pSA
4pSA4pSQICAg4pSCICDilJTilIDilIDilIDilIDilIDilIDilIDilJggICDilIIgICDilIINCiDi
lIIgIEEgIOKUnOKUgOKUgOKUgOKUpCAgICAgICAgICAgICAg4pSCIEIg4pSCDQog4pSU4pSA4pSA
4pSA4pSA4pSA4pSYICAg4pSCICDilIzilIDilIDilIDilIDilIDilIDilIDilJAgICDilIIgICDi
lIINCiAgICAgICAgICAg4pSU4pSA4pSA4pa6IE5BVCBCIOKUnOKUgOKUgOKUgOKWuiAgIOKUgg0K
ICAgICAgICAgICAgICDilJTilIDilIDilIDilIDilIDilIDilIDilJggICDilJTilIDilIDilIDi
lJgNCg0KTGV0IHVzIGFzc3VtZSBpbiBOQVQgQSAoMS4yLjMxLjQpLCB0aGUgY29ubmVjdGlvbnMg
aXMgc2V0dXAgYXMNCglPUklHSU5BTCBUVVBMRQkJICAgIFJFUExZIFRVUExFDQoxLjIuMy40OjEy
MzQ1IC0+IDUuNi43Ljg6NDIsIDUuNi43LjguNDIgLT4gMS4yLjMxLjQ6MzMzMzMNCg0KTGV0IHVz
IGFzc3VtZSBpbiBOQVQgQiAoMS4yLjMyLjQpLCB0aGUgY29ubmVjdGlvbnMgaXMgc2V0dXAgYXMN
CglPUklHSU5BTCBUVVBMRQkJICAgIFJFUExZIFRVUExFDQoxLjIuMy40OjEyMzQ1IC0+IDUuNi43
Ljk6NDIsIDUuNi43LjguNDIgLT4gMS4yLjMyLjQ6NDQ0NDQNCg0KU2luY2UgdGhlIHBvcnQgbnVt
YmVycyBhcmUgZGlmZmVyZW50IHdoZW4gdmlld2VkIGZyb20gQiwgdGhlIGFzc29jaWF0aW9uDQp3
aWxsIG5vdCBiZWNvbWUgbXVsdGlob21lZCwgd2l0aCBvbmx5IHRoZSBwcmltYXJ5IHBhdGggYmVp
bmcgYWN0aXZlLg0KTW9yZW92ZXIsIG9uIGEgTkFUL21pZGRsZWJveCByZXN0YXJ0LCB3ZSB3aWxs
IGVuZCB1cCBnZXR0aW5nIG5ldyBwb3J0cy4NCg0KSSB1bmRlcnN0YW5kIHRoaXMgaXMgYSBwcm9i
bGVtIGluIHRoZSB3YXkgU05BVCBydWxlcyBhcmUgY29uZmlndXJlZCwgbXkNCnByb3Bvc2FsIHdh
cyB0byBoYXZlIHRoaXMgZmxhZyBhcyBhIG1lYW5zIG9mIHByZXZlbnRpbmcgc3VjaCBhIHByb2Js
ZW0NCmV2ZW4gaWYgdGhlIHVzZXIgd2FudGVkIHRvLg0KDQo+PiBBcyBzcGVjaWZpZWQgaW4gUkZD
OTI2MCBhbGwgdHJhbnNwb3J0IGFkZHJlc3NlcyB1c2VkIGJ5IGFuIFNDVFAgZW5kcG9pbnQNCj4+
IE1VU1QgdXNlIHRoZSBzYW1lIHBvcnQgbnVtYmVyIGJ1dCBjYW4gdXNlIG11bHRpcGxlIElQIGFk
ZHJlc3Nlcy4gVGhhdA0KPj4gbWVhbnMgdGhhdCBhbGwgcGF0aHMgdGFrZW4gd2l0aGluIGFuIFND
VFAgYXNzb2NpYXRpb24gc2hvdWxkIGhhdmUgdGhlDQo+PiBzYW1lIHBvcnQgZXZlbiBpZiB0aGV5
IHBhc3MgdGhyb3VnaCBkaWZmZXJlbnQgTkFUL21pZGRsZWJveGVzIGluIHRoZQ0KPj4gbmV0d29y
ay4NCj4gLi4uIHRoZSByZmMgbWFuZGF0ZXMgdGhpcywgZXNwZWNpYWxseSBnaXZlbiB0aGUgZmFj
dCB0aGF0IGVuZHBvaW50cyBoYXZlDQo+IDAgY29udHJvbCBvbiBtaWRkbGVib3ggYmVoYXZpb3Vy
Lg0KPg0KPiBUaGlzIGZsYWcgd2lsbCBjb21wbGV0ZWx5IHByZXZlbnQgY29tbXVuaWNhdGlvbiBp
biBjYXNlIGFub3RoZXINCj4gbWlkZGxlYm94IGRvZXMgc3BvcnQgcmFuZG9taXphdGlvbiwgc28g
SSB3b25kZXIgd2h5IGl0cyBuZWVkZWQgLS0gSSBzZWUNCj4gbm8gYWR2YW50YWdlcyBidXQgSSBz
ZWUgYSBkb3duc2lkZS4NCg0KU2luY2UgdGhlIGZsYWcgaXMgb3B0aW9uYWwsIHRoZSBpZGVhIGlz
IHRvIGVuYWJsZSBpdCBvbmx5IG9uIGhvc3RzIHRoYXQNCmFyZSBwYXJ0IG9mIGRvY2tlci9rdWJl
cm5ldGVzIGVudmlyb25tZW50cyBhbmQgdXNlIE5BVCBpbiB0aGVpciBkYXRhcGF0aC4NCg0KPj4g
RGlzYWJsaW5nIHNvdXJjZSBwb3J0IHJhbmRvbWl6YXRpb24gcHJvdmlkZXMgYSBkZXRlcm1pbmlz
dGljIHNvdXJjZSBwb3J0DQo+PiBmb3IgdGhlIHJlbW90ZSBTQ1RQIGVuZHBvaW50IGZvciBhbGwg
cGF0aHMgdXNlZCBpbiB0aGUgU0NUUCBhc3NvY2lhdGlvbi4NCj4+IE9uIE5BVC9taWRkbGVib3gg
cmVzdGFydHMgd2Ugd2lsbCBhbHdheXMgZW5kIHVwIHdpdGggdGhlIHNhbWUgcG9ydCBhZnRlcg0K
Pj4gdGhlIHJlc3RhcnQsIGFuZCB0aGUgU0NUUCBlbmRwb2ludHMgaW52b2x2ZWQgaW4gdGhlIFND
VFAgYXNzb2NpYXRpb24gY2FuDQo+PiByZW1haW4gdHJhbnNwYXJlbnQgdG8gcmVzdGFydHMuDQo+
IENhbiB5b3UgZWxhYm9yYXRlPyBJZiB3ZSdyZSB0aGUgbWlkZGxlYm94IGFuZCB3ZSByZXN0YXJ0
ZWQsIHdlIGhhdmUgbm8NCj4gcmVjb3JkIG9mIHRoZSAib2xkIiBpbmNhcm5hdGlvbiBzbyB0aGVy
ZSBpcyBubyBzcG9ydCByZWFsbG9jYXRpb24uDQo+DQo+PiBPZiBjb3Vyc2UsIHRoZXJlIGlzIGEg
ZG93bnNpZGUgYXMgdGhpcyBtYWtlcyBpdCBpbXBvc3NpYmxlIHRvIGhhdmUNCj4+IG11bHRpcGxl
IFNDVFAgZW5kcG9pbnRzIGJlaGluZCBOQVQgdGhhdCB1c2UgdGhlIHNhbWUgc291cmNlIHBvcnQu
DQo+IEhtbT8gIE5vdCBmb2xsb3dpbmcuDQo+DQo+IDEuMi4zLjQ6MTIzNDUgLT4gNS42LjcuODo0
Mg0KPiAxLjIuMy40OjEyMzQ1IC0+IDUuNi43Ljg6NDMNCj4NCj4gLi4uIHNob3VsZCB3b3JrIGZp
bmUuIFNhbWUgZm9yDQo+IDEuMi4zLjQ6MTIzNDUgLT4gNS42LjcuODo0Mg0KPiAxLjIuMy40OjEy
MzQ1IC0+IDUuNi43Ljk6NDINCg0KSSBtZWFudCB0byBub3RlIHRoZSBsaW1pdGF0aW9uIHlvdSBy
aWdodGx5IHBvaW50ZWQgYWJvdmUsIHRoYXQgd2hlbiB0aGVyZQ0KaXMgYW4gZXhpc3RpbmcgY29u
bmVjdGlvbiwgdXNpbmcgdGhlICpzYW1lKiBzcG9ydDpzYWRkciAtPiBkcG9ydDpkYWRkciwgdGhl
DQpuZXcgY29ubmVjdGlvbiBhdHRlbXB0IHdpbGwgYmUgZHJvcHBlZC4gRm9yIGUuZy4NCg0KMS4y
LjMuNDE6MTIzNDUgLT4gNS42LjcuODo0MiAoRXhpc3RpbmcgY29ubmVjdGlvbikNCjEuMi4zLjQy
OjEyMzQ1IC0+IDUuNi43Ljg6NDIgKFRoaXMgY29ubmVjdGlvbiByZXF1ZXN0IHdpbGwgZmFpbCkN
Cg0KV2lsbCBiZSB0cmFuc2xhdGVkIHRvIGNvbmZsaWN0aW5nIHJlcGx5IHR1cGxlcw0KMS4yLjMu
NDA6MTIzNDUgPC0gNS42LjcuODo0Mg0KMS4yLjMuNDA6MTIzNDUgPC0gNS42LjcuODo0Mg0KDQo+
PiBCdXQsIHRoaXMgaXMgYSBsZXNzZXIgb2YgYSBwcm9ibGVtIHRoYW4gbG9zaW5nIGFuIGV4aXN0
aW5nIGFzc29jaWF0aW9uDQo+PiBhbHRvZ2V0aGVyLg0KPiBDYW4geW91IGVsYWJvcmF0ZT8gIEhv
dyBpcyBhbiBleGlzdGluZyBhc3NvY2F0aW9uIGxvc3Q/DQo+IEZvciBleGFtcGxlLCB3aGF0IHNl
cXVlbmNlIG9mIGV2ZW50cyBpcyBuZWVkZWQgdG8gcmVzdWx0IGluIGxvc3Mgb2YNCj4gYW4gZXhp
c3RpbmcgYXNzb2NpYXRpb24/DQoNCkNvbnNpZGVyIHR3byBTQ1RQIGFzc29jaWF0aW9ucyBBIC0+
IEMgYW5kIEIgLT4gQw0KQTogMS4yLjMuNDE6MTIzNDUNCkI6IDEuMi4zLjQyOjEyMzQ1DQpDOiA1
LjYuNy44OjQyIA0KTkFUIHB1YmxpYyBJUDogMS4yLjMuNDANCg0KICDilIzilIDilIDilIDilIDi
lIDilJANCiAg4pSCICBBICDilJzilIDilIDilIDilJANCiAg4pSU4pSA4pSA4pSA4pSA4pSA4pSY
ICAg4pSCICAgIOKUjOKUgOKUgOKUgOKUgOKUgOKUkCAgIOKUjOKUgOKUgOKUgOKUgOKUgOKUkA0K
ICAgICAgICAgICAg4pSc4pSA4pSA4pSA4pSA4pa6IE5BVCDilJzilIDilIDilIDilrogIEMgIOKU
gg0KICDilIzilIDilIDilIDilIDilIDilJAgICDilIIgICAg4pSU4pSA4pSA4pSA4pSA4pSA4pSY
ICAg4pSU4pSA4pSA4pSA4pSA4pSA4pSYDQogIOKUgiAgQiAg4pSc4pSA4pSA4pSA4pSYDQogIOKU
lOKUgOKUgOKUgOKUgOKUgOKUmA0KDQpMZXQgdXMgYXNzdW1lIGluIE5BVCAoMS4yLjMuNDApLCB0
aGUgY29ubmVjdGlvbnMgYXJlIHNldHVwIGFzDQoJT1JJR0lOQUwgVFVQTEUJCSAgICBSRVBMWSBU
VVBMRQ0KMS4yLjMuNDE6MTIzNDUgLT4gNS42LjcuODo0MiwgNS42LjcuOC40MiAtPiAxLjIuMy40
MDoxMjM0NQ0KMS4yLjMuNDI6MTIzNDUgLT4gNS42LjcuODo0MiwgNS42LjcuOC40MiAtPiAxLjIu
My40MDo0NDQ0NA0KDQpBZnRlciBhIHJlc3RhcnQgdGhlcmUgaXMgYSBjaGFuY2UgdGhhdCB0aGUg
Y29ubmVjdGlvbnMgd2lsbCBiZSBzZXR1cCBhcw0KCU9SSUdJTkFMIFRVUExFCQkgICAgUkVQTFkg
VFVQTEUNCjEuMi4zLjQxOjEyMzQ1IC0+IDUuNi43Ljg6NDIsIDUuNi43LjguNDIgLT4gMS4yLjMu
NDA6NTU1NTUNCjEuMi4zLjQyOjEyMzQ1IC0+IDUuNi43Ljg6NDIsIDUuNi43LjguNDIgLT4gMS4y
LjMuNDA6MTIzNDUNCg0KRnJvbSBDJ3MgcG9pbnQgb2YgdmlldyB0aGUgcG9ydCBudW1iZXJzIGZv
ciB0aGUgdHdvIGFzc29jaWF0aW9ucyB3aWxsIGJlIA0KZGlmZmVyZW50IGFmdGVyIGEgcmVzdGFy
dCwgaGVuY2UgdGhlcmUgY2FuIGJlIG5vIGNvbW11bmljYXRpb24gdXNpbmcgdGhlDQpleGlzdGlu
ZyBhc3NvY2lhdGlvbnMuDQoNCg0KDQo=
