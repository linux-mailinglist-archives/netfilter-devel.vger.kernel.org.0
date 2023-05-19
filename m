Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E1E709FE6
	for <lists+netfilter-devel@lfdr.de>; Fri, 19 May 2023 21:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjEST35 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 19 May 2023 15:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjEST35 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 19 May 2023 15:29:57 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8DE11F;
        Fri, 19 May 2023 12:29:56 -0700 (PDT)
Received: from localhost.localdomain (1.general.cascardo.us.vpn [10.172.70.58])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4B7C3412F9;
        Fri, 19 May 2023 19:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684524594;
        bh=XqikJRkTyn7SPlomXlryvsAz39twweAfWlM68DexsWI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=QuH1GRBwAJotTQ+aNt1mL0z+yl07hyUfJ/IwDSnZM9eFHAwt2iZOSj+0IjHnO4FtE
         sfBNxRCdxDKqal0LhpxslP2lfkAABeKB4dTFd8hmh1K1akm3bXkopkNJwUWiVsrW+r
         9iTjAtZut8OZr12C4NrxgSZ+q/zRtnfOV17cJs/W3K0Ecsb0mrhGvHBMy9sin+1rIQ
         QZP+wz27RLi5F8CK3bgTOVM7WtMK2JfYbcq2GEr0Wt9Su6V1ro3NahSKO+EZ7TLe0t
         AaMqT0NlgOYQUedFXIhKP+/jHE4D6zyAUrGIlHAfHpCrwL8AeW9/lc8eN0kRPetnUR
         F6dGkHxp4RHJw==
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     stable@vger.kernel.org
Cc:     pablo@netfilter.org, netfilter-devel@vger.kernel.org
Subject: [PATCH 4.14 0/1] netfilter: Fix EBUSY when removing objref
Date:   Fri, 19 May 2023 16:28:58 -0300
Message-Id: <20230519192859.2272157-1-cascardo@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

When removing a rule with an objref expression and the object it references in
the same batch, it will return EBUSY. The backported commit has a Fixes line
for one of the commits recently backported.

Pablo Neira Ayuso (1):
  netfilter: nf_tables: bogus EBUSY in helper removal from transaction

 net/netfilter/nft_objref.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

-- 
2.34.1

