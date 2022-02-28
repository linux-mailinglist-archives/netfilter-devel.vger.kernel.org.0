Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CED4C7C5E
	for <lists+netfilter-devel@lfdr.de>; Mon, 28 Feb 2022 22:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiB1Vrh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 28 Feb 2022 16:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiB1Vrh (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:47:37 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB45914ACB4
        for <netfilter-devel@vger.kernel.org>; Mon, 28 Feb 2022 13:46:56 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nOnr4-0004zD-AS; Mon, 28 Feb 2022 22:46:54 +0100
Date:   Mon, 28 Feb 2022 22:46:54 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] src: add tcp option reset support
Message-ID: <20220228214654.GA12167@breakpoint.cc>
References: <20220219133750.13369-1-fw@strlen.de>
 <sp5q78s5-723n-pq8q-np2s-nr279qpprs18@vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sp5q78s5-723n-pq8q-np2s-nr279qpprs18@vanv.qr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Jan Engelhardt <jengelh@inai.de> wrote:
> On Saturday 2022-02-19 14:37, Florian Westphal wrote:
> 
> >This allows to replace a tcp tcp option with nops, similar
> 
> tcp tcp

[..]

Applied this with the suggested fixups included, thanks Jan.
