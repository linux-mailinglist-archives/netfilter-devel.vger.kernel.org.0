Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26987B6286
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Sep 2019 13:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfIRLx1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 18 Sep 2019 07:53:27 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:42492 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726038AbfIRLx1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 18 Sep 2019 07:53:27 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iAYWT-0006DK-E0
        for netfilter-devel@vger.kernel.org; Wed, 18 Sep 2019 13:53:25 +0200
Date:   Wed, 18 Sep 2019 13:53:25 +0200
From:   Florian Westphal <fw@strlen.de>
To:     netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: What is 'dynamic' set flag supposed to mean?
Message-ID: <20190918115325.GM6961@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi.

Following example loads fine:
table ip NAT {
  set set1 {
    type ipv4_addr
    size 64
    flags dynamic,timeout
    timeout 1m
  }

  chain PREROUTING {
     type nat hook prerouting priority -101; policy accept;
  }
}

But adding/using this set doesn't work:
nft -- add rule NAT PREROUTING tcp dport 80 ip saddr @set1 counter
Error: Could not process rule: Operation not supported

This is because the 'dynamic' flag sets NFT_SET_EVAL.

According to kernel comment, that flag means:
 * @NFT_SET_EVAL: set can be updated from the evaluation path

The rule add is rejected from the lookup expression (nft_lookup_init)
which has:

if (set->flags & NFT_SET_EVAL)
    return -EOPNOTSUPP;

From looking at the git history, the NFT_SET_EVAL flag means that the
set contains expressions (i.e., a meter).

And I can see why doing a lookup on meters isn't meaningful.

Can someone please explain the exact precise meaning of 'dynamic'?
Was it supposed to mean 'set can be updated from packet path'?
Or was it supposed to mean 'set contains expressions'?

If its the latter, do we need a new NFT_SET flag to convey 'set
needs to support updates from packet path'?

Thanks.
