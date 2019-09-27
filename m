Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABC3ABFF13
	for <lists+netfilter-devel@lfdr.de>; Fri, 27 Sep 2019 08:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfI0GWZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 27 Sep 2019 02:22:25 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:5044 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfI0GWS (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 27 Sep 2019 02:22:18 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee35d8daa6b5f6-3c1ec; Fri, 27 Sep 2019 14:21:31 +0800 (CST)
X-RM-TRANSID: 2ee35d8daa6b5f6-3c1ec
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost (unknown[223.105.0.241])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65d8daa6924f-a9194;
        Fri, 27 Sep 2019 14:21:30 +0800 (CST)
X-RM-TRANSID: 2ee65d8daa6924f-a9194
From:   Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To:     Shuah Khan <shuah@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Julian Anastasov <ja@ssi.bg>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH v2 0/3] selftests: netfilter: introduce test cases for ipvs
Date:   Fri, 27 Sep 2019 14:21:03 +0800
Message-Id: <1569565266-31566-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This series patch include test cases for ipvs.

The test topology is who as below:
+--------------------------------------------------------------+
|                      |                                       |
|         ns0          |         ns1                           |
|      -----------     |     -----------    -----------        |
|      | veth01  | --------- | veth10  |    | veth12  |        |
|      -----------    peer   -----------    -----------        |
|           |          |                        |              |
|      -----------     |                        |              |
|      |  br0    |     |-----------------  peer |--------------|
|      -----------     |                        |              |
|           |          |                        |              |
|      ----------     peer   ----------      -----------       |
|      |  veth02 | --------- |  veth20 |     | veth21  |       |
|      ----------      |     ----------      -----------       |
|                      |         ns2                           |
|                      |                                       |
+--------------------------------------------------------------+

Test results:
# selftests: netfilter: ipvs.sh
# Testing DR mode...
# Testing NAT mode...
# Testing Tunnel mode...
# ipvs.sh: PASS
ok 6 selftests: netfilter: ipvs.sh

Haishuang Yan (3):
  selftests: netfilter: add ipvs test script
  selftests: netfilter: add ipvs nat test case
  selftests: netfilter: add ipvs tunnel test case

 tools/testing/selftests/netfilter/Makefile |   2 +-
 tools/testing/selftests/netfilter/ipvs.sh  | 234 +++++++++++++++++++++++++++++
 2 files changed, 235 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/netfilter/ipvs.sh

-- 
1.8.3.1



