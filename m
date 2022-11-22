Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7494F634094
	for <lists+netfilter-devel@lfdr.de>; Tue, 22 Nov 2022 16:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbiKVPwE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 22 Nov 2022 10:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiKVPwE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 22 Nov 2022 10:52:04 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872936EB5A
        for <netfilter-devel@vger.kernel.org>; Tue, 22 Nov 2022 07:52:02 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1oxVZ1-0006PN-Nf; Tue, 22 Nov 2022 16:51:59 +0100
Date:   Tue, 22 Nov 2022 16:51:59 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables-nft RFC 4/5] xlate-test: extra-escape of '"' for
 replay mode
Message-ID: <Y3zwH69RX+1XjnTM@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
References: <20221121111932.18222-1-fw@strlen.de>
 <20221121111932.18222-5-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121111932.18222-5-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Nov 21, 2022 at 12:19:31PM +0100, Florian Westphal wrote:
> Before, nft fails to restore some rules because it sees:
> insert rule ip filter INPUT iifname iifname ip ...
> 
> Add extra escaping for " so that the shell won't remove it and
> nft will see 'iifname "iifname"'.

This is fixing up the wrong side, see:

struct xt_xlate_{mt,tg}_params::escape_quotes

this is set if iptables-translate was called and unset if
iptables-restore-translate was called. I didn't invent this, but the
logic seems to be escape quotes when printing a command, don't when
printing a dump file content.

I have a patch in my queue which extends the conditional quoting to
interface names. Will submit it later today along with other fixes in
that corner.

Cheers, Phil
