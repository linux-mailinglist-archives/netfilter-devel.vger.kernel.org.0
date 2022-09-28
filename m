Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16E35EE4A6
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Sep 2022 20:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbiI1Sys (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 28 Sep 2022 14:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiI1Sys (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 28 Sep 2022 14:54:48 -0400
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0A61AD85
        for <netfilter-devel@vger.kernel.org>; Wed, 28 Sep 2022 11:54:45 -0700 (PDT)
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
        by m0050102.ppops.net-00190b01. (8.17.1.5/8.17.1.5) with ESMTP id 28SEmwnU029216;
        Wed, 28 Sep 2022 19:26:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=jan2016.eng;
 bh=EaqeA1mjjVh3Qnr7Vyl9AHYTRL/YDR6e0VFhKNUBLio=;
 b=ILMQZH3EUQpEX3WjlvD3lchQq2JTikZ1Uts//ZtCJx6Fn8oQsBbZlvfH51ZewIEy11sy
 e3CF5hLFDnZSDYTl20SqA5BVBLU068RsBmkTiukYjDYtq8Ya9RLHE/HZKSiS3+kB+D4H
 xU6qRSRxl+9C3+a8sScW6x5lbiK/Hhyi6l5ejOgAq1crJ1miCJzsWVKf+27kk6I47DpY
 upBLoaGnAtinaF3mCOVlr4r0CaCMU/vO33YtqzZOrpWN3kjgJLxEbK8uC2CaPvCur4NP
 /K9mHT1uzDSsRKuLPdx6d7pD120neNaKDm/+F9BqC7UaWZ24B6iqHDw4CFoauGGmJeDe 7Q== 
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61] (may be forged))
        by m0050102.ppops.net-00190b01. (PPS) with ESMTPS id 3juvuwjda1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 19:26:49 +0100
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
        by prod-mail-ppoint6.akamai.com (8.17.1.5/8.17.1.5) with ESMTP id 28SFnZ3P002079;
        Wed, 28 Sep 2022 14:26:49 -0400
Received: from email.msg.corp.akamai.com ([172.27.91.21])
        by prod-mail-ppoint6.akamai.com (PPS) with ESMTPS id 3juckuy8dt-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 14:26:49 -0400
Received: from usma1ex-dag4mb6.msg.corp.akamai.com (172.27.91.25) by
 usma1ex-dag4mb3.msg.corp.akamai.com (172.27.91.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Wed, 28 Sep 2022 14:26:23 -0400
Received: from bos-lhvuce.bos01.corp.akamai.com (172.28.220.70) by
 usma1ex-dag4mb6.msg.corp.akamai.com (172.27.91.25) with Microsoft SMTP Server
 id 15.2.1118.12 via Frontend Transport; Wed, 28 Sep 2022 14:26:23 -0400
Received: by bos-lhvuce.bos01.corp.akamai.com (Postfix, from userid 35863)
        id C62C715FA1F; Wed, 28 Sep 2022 14:26:23 -0400 (EDT)
From:   Vishwanath Pai <vpai@akamai.com>
To:     <pablo@netfilter.org>, <kadlec@netfilter.org>, <fw@strlen.de>
CC:     Vishwanath Pai <vpai@akamai.com>, <johunt@akamai.com>,
        <netfilter-devel@vger.kernel.org>
Subject: [PATCH v2 5/6] netfilter: ipset: Update the man page to include netmask/bitmask options
Date:   Wed, 28 Sep 2022 14:25:35 -0400
Message-ID: <20220928182536.602688-6-vpai@akamai.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928182536.602688-1-vpai@akamai.com>
References: <20220928182536.602688-1-vpai@akamai.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_07,2022-09-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209280108
X-Proofpoint-ORIG-GUID: OACTPzkoXqJBDnH67Oi2-nd_bDdkOhCp
X-Proofpoint-GUID: OACTPzkoXqJBDnH67Oi2-nd_bDdkOhCp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_07,2022-09-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 spamscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209280109
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

We added bitmask support to hash:ip and added both netmask and bitmask
to hash:net,net and hash:ip,port

Signed-off-by: Vishwanath Pai <vpai@akamai.com>
---
 src/ipset.8 | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/src/ipset.8 b/src/ipset.8
index 269b9b5..c607796 100644
--- a/src/ipset.8
+++ b/src/ipset.8
@@ -524,7 +524,7 @@ The \fBhash:ip\fR set type uses a hash to store IP host addresses (default) or
 network addresses. Zero valued IP address cannot be stored in a \fBhash:ip\fR
 type of set.
 .PP
-\fICREATE\-OPTIONS\fR := [ \fBfamily\fR { \fBinet\fR | \fBinet6\fR } ] [ \fBhashsize\fR \fIvalue\fR ] [ \fBmaxelem\fR \fIvalue\fR ] [ \fBbucketsize\fR \fIvalue\fR ] [ \fBnetmask\fP \fIcidr\fP ] [ \fBtimeout\fR \fIvalue\fR ] [ \fBcounters\fP ] [ \fBcomment\fP ] [ \fBskbinfo\fP ]
+\fICREATE\-OPTIONS\fR := [ \fBfamily\fR { \fBinet\fR | \fBinet6\fR } ] [ \fBhashsize\fR \fIvalue\fR ] [ \fBmaxelem\fR \fIvalue\fR ] [ \fBbucketsize\fR \fIvalue\fR ] [ \fBnetmask\fP \fIcidr\fP ] [ \fBbitmask\fP \fImask\fP ] [ \fBtimeout\fR \fIvalue\fR ] [ \fBcounters\fP ] [ \fBcomment\fP ] [ \fBskbinfo\fP ]
 .PP
 \fIADD\-ENTRY\fR := \fIipaddr\fR
 .PP
@@ -549,6 +549,9 @@ ipset create foo hash:ip netmask 30
 ipset add foo 192.168.1.0/24
 .IP 
 ipset test foo 192.168.1.2
+.TP
+\fBbitmask\fP \fImask\fP
+This works similar to \fBnetmask\fP but it will accept any valid IPv4/v6 address. It does not have to be a valid netmask.
 .SS hash:mac
 The \fBhash:mac\fR set type uses a hash to store MAC addresses. Zero valued MAC addresses cannot be stored in a \fBhash:mac\fR
 type of set. For matches on destination MAC addresses, see COMMENTS below.
@@ -648,7 +651,7 @@ over the second, so a nomatch entry could be potentially be ineffective if a mor
 first parameter existed with a suitable second parameter.
 Network address with zero prefix size cannot be stored in this type of set.
 .PP
-\fICREATE\-OPTIONS\fR := [ \fBfamily\fR { \fBinet\fR | \fBinet6\fR } ] [ \fBhashsize\fR \fIvalue\fR ] [ \fBmaxelem\fR \fIvalue\fR ] [ \fBbucketsize\fR \fIvalue\fR ] [ \fBtimeout\fR \fIvalue\fR ] [ \fBcounters\fP ] [ \fBcomment\fP ] [ \fBskbinfo\fP ]
+\fICREATE\-OPTIONS\fR := [ \fBfamily\fR { \fBinet\fR | \fBinet6\fR } ] [ \fBhashsize\fR \fIvalue\fR ] [ \fBmaxelem\fR \fIvalue\fR ] [ \fBbucketsize\fR \fIvalue\fR ] [ \fBbitmask\fP \fImask\fP ] [ \fBtimeout\fR \fIvalue\fR ] [ \fBcounters\fP ] [ \fBcomment\fP ] [ \fBskbinfo\fP ]
 .PP
 \fIADD\-ENTRY\fR := \fInetaddr\fR,\fInetaddr\fR
 .PP
@@ -680,6 +683,11 @@ values added to the first parameter of the set. The number of secondary prefixes
 further increases this as the list of secondary prefixes is traversed per primary
 prefix.
 .PP
+Optional \fBcreate\fR options:
+.TP
+\fBbitmask\fP \fImask\fP
+This works similar to \fBnetmask\fP but it will accept any valid IPv4/v6 address. It does not have to be a valid netmask.
+.PP
 Example:
 .IP
 ipset create foo hash:net,net
@@ -701,7 +709,7 @@ The \fBhash:ip,port\fR set type uses a hash to store IP address and port number
 The port number is interpreted together with a protocol (default TCP) and zero
 protocol number cannot be used.
 .PP
-\fICREATE\-OPTIONS\fR := [ \fBfamily\fR { \fBinet\fR | \fBinet6\fR } ] [ \fBhashsize\fR \fIvalue\fR ] [ \fBmaxelem\fR \fIvalue\fR ] [ \fBbucketsize\fR \fIvalue\fR ] [ \fBtimeout\fR \fIvalue\fR ] [ \fBcounters\fP ] [ \fBcomment\fP ] [ \fBskbinfo\fP ]
+\fICREATE\-OPTIONS\fR := [ \fBfamily\fR { \fBinet\fR | \fBinet6\fR } ] [ \fBhashsize\fR \fIvalue\fR ] [ \fBmaxelem\fR \fIvalue\fR ] [ \fBbucketsize\fR \fIvalue\fR ] [ \fBnetmask\fP \fIcidr\fP ] [ \fBbitmask\fP \fImask\fP ] [ \fBtimeout\fR \fIvalue\fR ] [ \fBcounters\fP ] [ \fBcomment\fP ] [ \fBskbinfo\fP ]
 .PP
 \fIADD\-ENTRY\fR := \fIipaddr\fR,[\fIproto\fR:]\fIport\fR
 .PP
@@ -741,6 +749,18 @@ The \fBhash:ip,port\fR type of sets require
 two \fBsrc\fR/\fBdst\fR parameters of the \fBset\fR match and \fBSET\fR
 target kernel modules.
 .PP
+Optional \fBcreate\fR options:
+.TP
+\fBnetmask\fP \fIcidr\fP
+When the optional \fBnetmask\fP parameter specified, network addresses will be
+stored in the set instead of IP host addresses. The \fIcidr\fP prefix value must be
+between 1\-32 for IPv4 and between 1\-128 for IPv6. An IP address will be in the set
+if the network address, which is resulted by masking the address with the netmask,
+can be found in the set.
+.TP
+\fBbitmask\fP \fImask\fP
+This works similar to \fBnetmask\fP but it will accept any valid IPv4/v6 address. It does not have to be a valid netmask.
+.PP
 Examples:
 .IP 
 ipset create foo hash:ip,port
-- 
2.25.1

