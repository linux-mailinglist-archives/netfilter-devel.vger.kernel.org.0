Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5567871F287
	for <lists+netfilter-devel@lfdr.de>; Thu,  1 Jun 2023 21:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjFATBT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 1 Jun 2023 15:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbjFATBO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 1 Jun 2023 15:01:14 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B41318C
        for <netfilter-devel@vger.kernel.org>; Thu,  1 Jun 2023 12:01:12 -0700 (PDT)
Date:   Thu, 1 Jun 2023 21:01:10 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     ValdikSS <iam@valdikss.org.ru>, netfilter-devel@vger.kernel.org
Subject: Re: xtables-addons: ipp2p does not block TCP traffic with nonlinear
 skb
Message-ID: <ZHjq9njpY29PuTue@calendula>
References: <2b05bb89-08bf-b3b1-c2d7-9b391953f303@valdikss.org.ru>
 <7rr4q976-5qn6-382r-0pp-66rq492r9376@vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7rr4q976-5qn6-382r-0pp-66rq492r9376@vanv.qr>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, May 31, 2023 at 11:41:07AM +0200, Jan Engelhardt wrote:
> 
> On Wednesday 2023-05-31 08:42, ValdikSS wrote:
> > However, it's not getting processed due to nonlinear skb:
> >
> >> static bool
> >> ipp2p_mt(const struct sk_buff *skb, struct xt_action_param *par)
> >>  /* make sure that skb is linear */
> >>  if (skb_is_nonlinear(skb)) {
> >>   if (info->debug)
> >>   	printk("IPP2P.match: nonlinear skb found\n");
> >>  	return 0;
> >>  }
> 
> It should be possible to just take the code from xt_ECHO and call
> 
> if (skb_linearize(skb) < 0)
> 	return false;
> 
> However, none of the xtables matches in the Linux kernel do this linearization,
> at least not that I can see directly. Or xt_string's call to skb_find_text is
> magic..

skb_find_text() deals with non-linear skbuff, see skb_seq_read().
