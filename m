Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FA35BA79C
	for <lists+netfilter-devel@lfdr.de>; Fri, 16 Sep 2022 09:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiIPHzq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 16 Sep 2022 03:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIPHzp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 16 Sep 2022 03:55:45 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01hn2208.outbound.protection.outlook.com [52.100.223.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B3927B36;
        Fri, 16 Sep 2022 00:55:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSauS//GL+KF0H5psf1kEyTzU/QKyJ/wsWUKjguVqWbgfuTiKSCJsDwhPADk2M95IlTqTFpABjzCnmGscjJ4mxkINA8SEaj9gmtGs4m1sTGKgXunYEcK9nW4qsjBfNrGW4xCzVm/wZgs424ZmMZ9vkGnUxn1mFPQrELidlZocFtEkrLjQR7AQhttx+8i8pIz60gknMsWGUUzzVE1Js8W0Hov4OB6UtNybhAK0tsbvm3LE9UoxdIl/81hfnNj8spkkqsX+9wPkc0eo2CLievi+Sbh8rLDzlJZKl25LmL/H5YU/L10TQ9XEcv4AD4hk86uYIZA0z24+6pT3molKequjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bs10Md+15nMnyayKLyd22Uv+/ZH79IcFcpzuzGLq1Fg=;
 b=R4M0l3gYzWsQC6kaK4J57ttCksToEb1qeMUsL24oJ4Tbczy3J78tDxp7zrv3nNG6l8vJSgX11l9nhO+3BB2bjEs2F4YtOFoq+u7DhLAclkhUrcWYnMkjAHn0HHWm6W02GY2pEgnyHsDIMSt0h7UDyuVAiEkBRNi3loqgf8zNChYNu1RA9iPH36ZifAuk6FEcg7bJUMoqJS2oO1N9q8hE1QP/ALJbZGTUPWy4RFcSbpngtm1xhxYRLabmJhPGGnXEsOOowzPom733dN5orVZyR54SIsgFmk4FdAujBfzoqV08Nmwd/doxxzle58VIUl1Y2q/G/RpjRYog+nwZJSXx1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 138.199.21.193) smtp.rcpttodomain=uniza.sk smtp.mailfrom=t4.cims.jp;
 dmarc=bestguesspass action=none header.from=t4.cims.jp; dkim=none (message
 not signed); arc=none (0)
Received: from SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16) by
 KL1PR0401MB4243.apcprd04.prod.outlook.com (2603:1096:820:2a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.14; Fri, 16 Sep
 2022 07:55:41 +0000
Received: from SG2APC01FT0035.eop-APC01.prod.protection.outlook.com
 (2603:1096:4:c7:cafe::f3) by SG2P153CA0029.outlook.office365.com
 (2603:1096:4:c7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.3 via Frontend
 Transport; Fri, 16 Sep 2022 07:55:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 138.199.21.193)
 smtp.mailfrom=t4.cims.jp; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=t4.cims.jp;
Received-SPF: Pass (protection.outlook.com: domain of t4.cims.jp designates
 138.199.21.193 as permitted sender) receiver=protection.outlook.com;
 client-ip=138.199.21.193; helo=User; pr=M
Received: from mail.prasarana.com.my (58.26.8.158) by
 SG2APC01FT0035.mail.protection.outlook.com (10.13.37.242) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Fri, 16 Sep 2022 07:55:41 +0000
Received: from MRL-EXH-02.prasarana.com.my (10.128.66.101) by
 MRL-EXH-01.prasarana.com.my (10.128.66.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 16 Sep 2022 15:55:00 +0800
Received: from User (138.199.21.193) by MRL-EXH-02.prasarana.com.my
 (10.128.66.101) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Fri, 16 Sep 2022 15:54:36 +0800
Reply-To: <rhashimi202222@kakao.com>
From:   Consultant Swift Capital Loans Ltd <info@t4.cims.jp>
Subject: I hope you are doing well, and business is great!
Date:   Fri, 16 Sep 2022 15:55:13 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1251"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <b6429daf-2932-4b6e-a864-288fde86968b@MRL-EXH-02.prasarana.com.my>
To:     Undisclosed recipients:;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[138.199.21.193];domain=User
X-MS-Exchange-ExternalOriginalInternetSender: ip=[138.199.21.193];domain=User
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2APC01FT0035:EE_|KL1PR0401MB4243:EE_
X-MS-Office365-Filtering-Correlation-Id: e9dc1ae1-5a6c-4b60-f93a-08da97b8d9dc
X-MS-Exchange-AtpMessageProperties: SA|SL
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?windows-1251?Q?NIJdcyhay8k1slOc5ZEE08sDIqhpxYHGIokqcN523IFIkwwlQo6DHGVA?=
 =?windows-1251?Q?N59y4b40bxvxliUhojn9ZZ3zBIa22aiKsaBgFqEq4ynFQguk6glHPKe0?=
 =?windows-1251?Q?ScS/Eu15eAHqR1+Jkpsk3hyiBR6iYsF8uXHu1M3A6HHMbYhBSclOwZ12?=
 =?windows-1251?Q?f5Fbpay7I6kAefWuullseOkWZFGc2mN3AdZQX9NaUC/3Zrrotw004eTn?=
 =?windows-1251?Q?3EHeiXI0oQ2UC4Lg8+pfzFxXsqBEXNt3e8xXGABHWpzfKngVEIiURmGS?=
 =?windows-1251?Q?26SRWu/hBGS6oIbIMuDxV2KwMuAs3OrFb17K+WsyPiJt2oS2d/TN3YDY?=
 =?windows-1251?Q?DT5PBPEn4utb9qzBd0kmnni05oBnTorgR02cP0/dBVaAvx01HrtyC8UJ?=
 =?windows-1251?Q?BW5Z/gZpx42VvmUsvx7uR7ZiarAKKHyK1+oajW/cAp+aSi1F4nqwlJ5w?=
 =?windows-1251?Q?lKK37Omc+xdM1eBET5vlvxqTnasjRBH4X5J71OVFILpF1/u/nHoWPVSV?=
 =?windows-1251?Q?CdsElVkheRZFVs+x+/gYXkVvPiTu2ffXoBJfotlchYyIcfQjqvSJ72OD?=
 =?windows-1251?Q?3sT3KmSjPqJLFYjJr0IPg19dDyUMOdhzz6YyJ1PC0LWHI4g+tcxmBX0P?=
 =?windows-1251?Q?Sw+90ugXQx8+d33Cudoht7TJVM3WWAquaaPnXWpEu6iQIpq3n/cu7kJT?=
 =?windows-1251?Q?J2FRZ91ledarqUIljB+WOJIlRaInKVpIWHiYOK+nQn9rWvnOtqwg4+98?=
 =?windows-1251?Q?ZVO4j2vF84JLe5Wr2vlCOjlSLwFJi/WQjJx3Bz6fzaEBzfG+a5ZDHXy2?=
 =?windows-1251?Q?AdSk3BuVOESj8NY03jPsn6uNGFmLUa+jsT3myql5jkjuXO3v3kucMfWH?=
 =?windows-1251?Q?3Anu0YWCpabDepJqHWtjY1wLeAQi1gpww8avrk8k+2CQoxtnolIPMqSV?=
 =?windows-1251?Q?oZSq3mg0RHygX3CHcxSgSmiCnFedvAlQ5pAfLNVZlAb2Sv9HKH3LEp9y?=
 =?windows-1251?Q?lJIuTJzk3+FFI+tNr9qsDmUZf8C1/TxeQdF8sc3Z0esEwPGoAPrKIUuq?=
 =?windows-1251?Q?nErMt8JfytEhY53VAf8bsxHh4SJY+Y/WjJvxmaRo6ze0b0YE8bhZeJrx?=
 =?windows-1251?Q?xu9P/XCzu4resMPbkomx+9Jgn+x3D0wO2+h7a+7moT0bgfFvPa6KwRNV?=
 =?windows-1251?Q?fgE7A8oNUSSV2TQya+0qA4lRLpA5CbOGhT0vI8wi2PzigH+FunkAgAbE?=
 =?windows-1251?Q?KX2isxVteAoL13BWcHb3NJy1ABVs21VVXm80WIQWCxN9rVtnsIMwYgtH?=
 =?windows-1251?Q?nTREY4kisFj8wpV88DHOK05sMt4XB40kaz++LLRCui35iL36XMsXMVQ3?=
 =?windows-1251?Q?eCpOkFXXdEYaVOkVhY0niZPgD3u+uRxcE/n3c8xbRg0uR6LgOTRKGGG4?=
 =?windows-1251?Q?8vwIxtR/ipxPtKvBMU956M7pRqroqj2Wkh1j3hBVP7vdUx7qinjLcCC+?=
 =?windows-1251?Q?8pfHcEvDfD4nFw2iW0WvNuY+CaupT0nTj4WCN2wJrcQIXEsLNSY=3D?=
X-Forefront-Antispam-Report: CIP:58.26.8.158;CTRY:JP;LANG:en;SCL:9;SRV:;IPV:NLI;SFV:SPM;H:User;PTR:unn-138-199-21-193.datapacket.com;CAT:OSPM;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199015)(46966006)(40470700004)(336012)(35950700001)(956004)(31696002)(32850700003)(47076005)(81166007)(156005)(82740400003)(316002)(5660300002)(7366002)(8936002)(498600001)(40480700001)(70586007)(7406005)(4744005)(70206006)(82310400005)(8676002)(41300700001)(86362001)(109986005)(7416002)(2906002)(6666004)(26005)(9686003)(40460700003)(36906005)(31686004)(66899012)(2700400008);DIR:OUT;SFP:1501;
X-OriginatorOrg: myprasarana.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 07:55:41.0479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9dc1ae1-5a6c-4b60-f93a-08da97b8d9dc
X-MS-Exchange-CrossTenant-Id: 3cbb2ff2-27fb-4993-aecf-bf16995e64c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3cbb2ff2-27fb-4993-aecf-bf16995e64c0;Ip=[58.26.8.158];Helo=[mail.prasarana.com.my]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT0035.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB4243
X-Spam-Status: Yes, score=6.2 required=5.0 tests=AXB_XMAILER_MIMEOLE_OL_024C2,
        AXB_X_FF_SEZ_S,BAYES_50,FORGED_MUA_OUTLOOK,FSL_CTYPE_WIN1251,
        FSL_NEW_HELO_USER,HEADER_FROM_DIFFERENT_DOMAINS,NSL_RCVD_FROM_USER,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5213]
        *  0.0 NSL_RCVD_FROM_USER Received from User
        *  0.0 FSL_CTYPE_WIN1251 Content-Type only seen in 419 spam
        *  3.2 AXB_X_FF_SEZ_S Forefront sez this is spam
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [52.100.223.208 listed in wl.mailspike.net]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [52.100.223.208 listed in list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        *  0.2 HEADER_FROM_DIFFERENT_DOMAINS From and EnvelopeFrom 2nd level
        *      mail domains are different
        *  0.0 AXB_XMAILER_MIMEOLE_OL_024C2 Yet another X header trait
        *  0.0 FSL_NEW_HELO_USER Spam's using Helo and User
        *  1.9 FORGED_MUA_OUTLOOK Forged mail pretending to be from MS Outlook
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hello,

I hope you are doing well, and business is great!
However, if you need working capital to further grow and expand your business, we may be a perfect fit for you. I am Ms. Kaori Ichikawa Swift Capital Loans Ltd Consultant, Our loans are NOT based on your personal credit, and NO collateral is required.

We are a Direct Lender who can approve your loan today, and fund as Early as Tomorrow.

Once your reply I will send you the official website to complete your application

Waiting for your reply.

Regards
Ms. Kaori Ichikawa
Consultant Swift Capital Loans Ltd
