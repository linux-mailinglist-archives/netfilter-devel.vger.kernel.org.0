Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1A0775A24
	for <lists+netfilter-devel@lfdr.de>; Wed,  9 Aug 2023 13:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjHILFj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 9 Aug 2023 07:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjHILFj (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:05:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9A0ED;
        Wed,  9 Aug 2023 04:05:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A4096309F;
        Wed,  9 Aug 2023 11:05:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A1AC433C8;
        Wed,  9 Aug 2023 11:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579137;
        bh=u4hkklQ7mPd5TNvxqqKW2I1ApRm6cAGp/u7Ip4YwA+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uCitcEinsKITepuAe4J21oPfXpr8osBXqrY8gj9YaWIksRRf30IB7KxCWKq373Rzz
         KiAjmVrfgk6x+JklT4V0g+CmJANcj8UjH6946euEbYihx2+w9HjWPnTnLgJ2ZLpkoi
         u35MnbEqdAjWpgI7cVnl0A1F84OGUZyi4e/OLEss=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org, netfilter-devel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 089/204] netfilter: nf_tables: unbind non-anonymous set if rule construction fails
Date:   Wed,  9 Aug 2023 12:40:27 +0200
Message-ID: <20230809103645.623787672@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ 3e70489721b6c870252c9082c496703677240f53 ]

Otherwise a dangling reference to a rule object that is gone remains
in the set binding list.

Fixes: 26b5a5712eb8 ("netfilter: nf_tables: add NFT_TRANS_PREPARE_ERROR to deal with bound set/chain")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_tables_api.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3461,6 +3461,8 @@ void nf_tables_deactivate_set(const stru
 		nft_set_trans_unbind(ctx, set);
 		if (set->flags & NFT_SET_ANONYMOUS)
 			nft_deactivate_next(ctx->net, set);
+		else
+			list_del_rcu(&binding->list);
 
 		set->use--;
 		break;


