Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A45175D734
	for <lists+netfilter-devel@lfdr.de>; Sat, 22 Jul 2023 00:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjGUWN1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 21 Jul 2023 18:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGUWN1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 21 Jul 2023 18:13:27 -0400
Received: from taras.nevrast.org (unknown [IPv6:2a05:d01c:431:aa03:b7e1:333d:ea2a:b14e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD52D2733
        for <netfilter-devel@vger.kernel.org>; Fri, 21 Jul 2023 15:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20220717; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XD1mFZNTl5k5EQtbL9XtjOX5TsZx1z08hub8AAdzDG0=; b=l9n0f0ME0fLGsfM8aUbzHaB5ee
        cdfnMYkgAHyoZH0QpySfxBtpK8iNkYQqPHuIC6/Xk0eoaA7Yp3/AtX9fYjppkwalv0++3t71l4Gt0
        Brq5x/yfwPeQq3PP6adiGI4f7EUDWgkMAsC1NDp1StqJsmmnl6qFQz9Fvo8hyvAyYqWCTflRLg3ul
        0Btf2xQDYHCiKePqp9lM7XUlOEsnSpInr8X4v7DmAD20MSg5+Sav2374jE/cVjApwjEjbLrFriZde
        vrfCXXnjMdnFFLQMNsEdTNQ9aKTovhD3M0VDkHzcsAtMFfdAIPhTyRgQK97VW+GSXOyaAWImOX5ms
        X6uo9RCQ==;
Received: from [2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608] (helo=ulthar.dreamlands)
        by taras.nevrast.org with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <jeremy@azazel.net>)
        id 1qMyNH-0052Ng-1P
        for netfilter-devel@vger.kernel.org;
        Fri, 21 Jul 2023 23:13:23 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH ipset] bash-completion: fix syntax error
Date:   Fri, 21 Jul 2023 23:13:11 +0100
Message-Id: <20230721221311.1582661-1-jeremy@azazel.net>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on taras.nevrast.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

There is a syntax error in a redirection:

  $ bash -x utils/ipset_bash_completion/ipset
  + shopt -s extglob
  utils/ipset_bash_completion/ipset: line 365: syntax error near unexpected token `('
  utils/ipset_bash_completion/ipset: line 365: `done < <(PATH=${PATH}:/sbin ( command ip -o link show ) )'

Move the environment variable assignment into the sub-shell.

Fixes: da6242e17583 ("Updated utilities")
Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1041605
Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 utils/ipset_bash_completion/ipset | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/ipset_bash_completion/ipset b/utils/ipset_bash_completion/ipset
index d258be234806..fc95d4043865 100644
--- a/utils/ipset_bash_completion/ipset
+++ b/utils/ipset_bash_completion/ipset
@@ -362,7 +362,7 @@ _ipset_get_ifnames() {
 while read -r; do
     REPLY="${REPLY#*: }"
     printf "%s\n" ${REPLY%%:*}
-done < <(PATH=${PATH}:/sbin ( command ip -o link show ) 2>/dev/null)
+done < <(( PATH=${PATH}:/sbin command ip -o link show ) 2>/dev/null)
 }
 
 _ipset_get_iplist() {
-- 
2.40.1

