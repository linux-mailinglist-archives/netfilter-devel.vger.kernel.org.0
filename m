Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C441FCCA86
	for <lists+netfilter-devel@lfdr.de>; Sat,  5 Oct 2019 16:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfJEOiU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 5 Oct 2019 10:38:20 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:5538 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfJEOiU (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 5 Oct 2019 10:38:20 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee35d98aabf48e-c327d; Sat, 05 Oct 2019 22:37:53 +0800 (CST)
X-RM-TRANSID: 2ee35d98aabf48e-c327d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost (unknown[223.105.0.241])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee95d98aabf086-fd9ab;
        Sat, 05 Oct 2019 22:37:52 +0800 (CST)
X-RM-TRANSID: 2ee95d98aabf086-fd9ab
From:   Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To:     Shuah Khan <shuah@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        Simon Horman <horms@verge.net.au>
Cc:     Julian Anastasov <ja@ssi.bg>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH v4 0/3] selftests: netfilter: introduce test cases for ipvs
Date:   Sat,  5 Oct 2019 22:37:42 +0800
Message-Id: <1570286265-15855-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
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
|      |  veth02 | --------- |  veth20 |     | veth12  |       |
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



