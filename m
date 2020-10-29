Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B944A29E8C5
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Oct 2020 11:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgJ2KPl (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 29 Oct 2020 06:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgJ2KPl (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:15:41 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAE0C0613D2
        for <netfilter-devel@vger.kernel.org>; Thu, 29 Oct 2020 03:15:41 -0700 (PDT)
Received: from [90.77.255.23] (helo=localhost.localdomain)
        by ganesha.gnumonks.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <pablo@netfilter.org>)
        id 1kY4xu-0001Xr-SN
        for netfilter-devel@vger.kernel.org; Thu, 29 Oct 2020 11:15:37 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_conntrack] conntrack: add flush filter command
Date:   Thu, 29 Oct 2020 11:15:22 +0100
Message-Id: <20201029101522.9028-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.9 (--)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The NFCT_Q_FLUSH command flushes both IPv4 and IPv6 conntrack tables.
Add new command NFCT_Q_FLUSH_FILTER that allows to flush based on the
family to retain backward compatibility on NFCT_Q_FLUSH.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/libnetfilter_conntrack/libnetfilter_conntrack.h | 1 +
 src/conntrack/api.c                                     | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/libnetfilter_conntrack/libnetfilter_conntrack.h b/include/libnetfilter_conntrack/libnetfilter_conntrack.h
index c5c6b615a3bf..f02d827761a8 100644
--- a/include/libnetfilter_conntrack/libnetfilter_conntrack.h
+++ b/include/libnetfilter_conntrack/libnetfilter_conntrack.h
@@ -452,6 +452,7 @@ enum nf_conntrack_query {
 	NFCT_Q_CREATE_UPDATE,
 	NFCT_Q_DUMP_FILTER,
 	NFCT_Q_DUMP_FILTER_RESET,
+	NFCT_Q_FLUSH_FILTER,
 };
 
 extern int nfct_query(struct nfct_handle *h,
diff --git a/src/conntrack/api.c b/src/conntrack/api.c
index 78d7d613d925..b7f64fb43ce8 100644
--- a/src/conntrack/api.c
+++ b/src/conntrack/api.c
@@ -831,6 +831,9 @@ __build_query_ct(struct nfnl_subsys_handle *ssh,
 		nfct_fill_hdr(req, IPCTNL_MSG_CT_DELETE, NLM_F_ACK, *family,
 			      NFNETLINK_V0);
 		break;
+	case NFCT_Q_FLUSH_FILTER:
+		nfct_fill_hdr(req, IPCTNL_MSG_CT_DELETE, NLM_F_ACK, *family, 1);
+		break;
 	case NFCT_Q_DUMP:
 		nfct_fill_hdr(req, IPCTNL_MSG_CT_GET, NLM_F_DUMP, *family,
 			      NFNETLINK_V0);
-- 
2.20.1

