Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2B2EA2C4
	for <lists+netfilter-devel@lfdr.de>; Wed, 30 Oct 2019 18:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfJ3Rt6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 30 Oct 2019 13:49:58 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:45218 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbfJ3Rt6 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 30 Oct 2019 13:49:58 -0400
Received: from localhost ([::1]:58308 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iPs6X-00080V-Ca; Wed, 30 Oct 2019 18:49:57 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [libnftnl PATCH 1/2] libnftnl.map: Export nftnl_{obj,flowtable}_set_data()
Date:   Wed, 30 Oct 2019 18:49:47 +0100
Message-Id: <20191030174948.12493-1-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

In order to deprecate nftnl_{obj,flowtable}_set() functions, these must
to be made available.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/libnftnl.map | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/libnftnl.map b/src/libnftnl.map
index 3ddb9468c96c3..e810c4de445f3 100644
--- a/src/libnftnl.map
+++ b/src/libnftnl.map
@@ -354,4 +354,6 @@ LIBNFTNL_12 {
 
 LIBNFTNL_13 {
   nftnl_set_list_lookup_byname;
+  nftnl_obj_set_data;
+  nftnl_flowtable_set_data;
 } LIBNFTNL_12;
-- 
2.23.0

