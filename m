Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5DD21BB1B9
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Apr 2020 00:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgD0Wzk (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 27 Apr 2020 18:55:40 -0400
Received: from correo.us.es ([193.147.175.20]:38434 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgD0Wzk (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 27 Apr 2020 18:55:40 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 4E8C9D2DA0B
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Apr 2020 00:55:37 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 4158DBAAA1
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Apr 2020 00:55:37 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 366D6BAAA3; Tue, 28 Apr 2020 00:55:37 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 23776BAAA1
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Apr 2020 00:55:35 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 28 Apr 2020 00:55:35 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 039A942EF9E1
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Apr 2020 00:55:34 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnftnl] udata: add NFTNL_UDATA_SET_DATA_INTERVAL
Date:   Tue, 28 Apr 2020 00:55:32 +0200
Message-Id: <20200427225532.19825-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Use this field to specify that set element data specifies an interval.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/libnftnl/udata.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/libnftnl/udata.h b/include/libnftnl/udata.h
index 1d57bc3dce16..661493b48618 100644
--- a/include/libnftnl/udata.h
+++ b/include/libnftnl/udata.h
@@ -25,6 +25,7 @@ enum nftnl_udata_set_types {
 	NFTNL_UDATA_SET_KEY_TYPEOF,
 	NFTNL_UDATA_SET_DATA_TYPEOF,
 	NFTNL_UDATA_SET_EXPR,
+	NFTNL_UDATA_SET_DATA_INTERVAL,
 	__NFTNL_UDATA_SET_MAX
 };
 #define NFTNL_UDATA_SET_MAX (__NFTNL_UDATA_SET_MAX - 1)
-- 
2.20.1

