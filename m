Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDBA5B3566
	for <lists+netfilter-devel@lfdr.de>; Fri,  9 Sep 2022 12:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiIIKmQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 9 Sep 2022 06:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiIIKmP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 9 Sep 2022 06:42:15 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D887138125
        for <netfilter-devel@vger.kernel.org>; Fri,  9 Sep 2022 03:42:14 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: conntrack: remove nf_conntrack_helper documentation
Date:   Fri,  9 Sep 2022 12:42:11 +0200
Message-Id: <20220909104211.61999-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This toggle has been already remove by b118509076b3 ("netfilter: remove
nf_conntrack_helper sysctl and modparam toggles").

Remove the documentation entry for this toggle too.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 Documentation/networking/nf_conntrack-sysctl.rst | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/Documentation/networking/nf_conntrack-sysctl.rst b/Documentation/networking/nf_conntrack-sysctl.rst
index 834945ebc4cd..1120d71f28d7 100644
--- a/Documentation/networking/nf_conntrack-sysctl.rst
+++ b/Documentation/networking/nf_conntrack-sysctl.rst
@@ -70,15 +70,6 @@ nf_conntrack_generic_timeout - INTEGER (seconds)
 	Default for generic timeout.  This refers to layer 4 unknown/unsupported
 	protocols.
 
-nf_conntrack_helper - BOOLEAN
-	- 0 - disabled (default)
-	- not 0 - enabled
-
-	Enable automatic conntrack helper assignment.
-	If disabled it is required to set up iptables rules to assign
-	helpers to connections.  See the CT target description in the
-	iptables-extensions(8) man page for further information.
-
 nf_conntrack_icmp_timeout - INTEGER (seconds)
 	default 30
 
-- 
2.30.2

