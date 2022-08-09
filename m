Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597C858D940
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Aug 2022 15:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbiHINQz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 9 Aug 2022 09:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiHINQx (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 9 Aug 2022 09:16:53 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0E613D3C
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Aug 2022 06:16:51 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1oLP6E-0006EH-07; Tue, 09 Aug 2022 15:16:46 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     alexanderduyck@fb.com, edumazet@google.com,
        Florian Westphal <fw@strlen.de>
Subject: [PATCH nf 0/4] netfilter: conntrack: remove 64kb max size assumptions
Date:   Tue,  9 Aug 2022 15:16:31 +0200
Message-Id: <20220809131635.3376-1-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Some of our dated conntrack helpers assume skbs can't contain
tcp packets larger than 64kb.

Update those.  For SANE, I don't see a reason for the
'full-packet-copy', just extract the sane header.

For h323, packet gets capped at 64k; larger one will be
seen as truncated.

For irc, cap at 4k: a line length should not exceed 512 bytes.
For ftp, use skb_linearize(), its the most simple way to resolve this.

Florian Westphal (4):
  netfilter: conntrack: sane: remove pseudo skb linearization
  netfilter: conntrack: h323: cap packet size at 64k
  netfilter: conntrack_ftp: prefer skb_linearize
  netfilter: conntrack_irc: cap packet search space to 4k

 net/netfilter/nf_conntrack_ftp.c       | 24 +++------
 net/netfilter/nf_conntrack_h323_main.c | 10 +++-
 net/netfilter/nf_conntrack_irc.c       | 12 +++--
 net/netfilter/nf_conntrack_sane.c      | 68 ++++++++++++--------------
 4 files changed, 54 insertions(+), 60 deletions(-)

-- 
2.35.1

