Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97A16FDC02
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 May 2023 12:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236707AbjEJK4W (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 10 May 2023 06:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbjEJKzp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 10 May 2023 06:55:45 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 055AF7EF9
        for <netfilter-devel@vger.kernel.org>; Wed, 10 May 2023 03:54:44 -0700 (PDT)
Date:   Wed, 10 May 2023 12:54:28 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] evaluate: Reject set stmt refs to sets without
 dynamic flag
Message-ID: <ZFt35MXmXZWxcb56@calendula>
References: <20230503105022.5728-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230503105022.5728-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, May 03, 2023 at 12:50:22PM +0200, Phil Sutter wrote:
> This is a revert of commit 8d443adfcc8c1 ("evaluate: attempt to set_eval
> flag if dynamic updates requested"), implementing the alternative
> mentioned in the comment it added.
> 
> Reason is the inconsistent behaviour when applying the same ruleset
> twice: In the first call, the set lacking 'dynamic' flag does not exist
> and is therefore added to the cache. Consequently, both the 'add set'
> command and the set statement point at the same set object. In the
> second call, a set with same name exists already, so the object created
> for 'add set' command is not added to cache and consequently not updated
> with the missing flag. The kernel thus rejects the NEWSET request as the
> existing set differs from the new one.

# cat test.nft
flush ruleset

table ip test {
        set dlist {
                type ipv4_addr
                size 65535
        }

        chain output {
                type filter hook output priority filter; policy accept;
                udp dport 1234 update @dlist { ip daddr } counter packets 0 bytes 0
        }
}
# nft -f test.nft
# nft -f test.nft
# nft list ruleset
table ip test {
        set dlist {
                type ipv4_addr
                size 65535
                flags dynamic
        }

        chain output {
                type filter hook output priority filter; policy accept;
                udp dport 1234 update @dlist { ip daddr } counter packets 0 bytes 0
        }
}

What are the steps to reproduce this? Did I misunderstand?
