Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC48E5780CF
	for <lists+netfilter-devel@lfdr.de>; Mon, 18 Jul 2022 13:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbiGRLcf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 18 Jul 2022 07:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbiGRLce (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:32:34 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 370E21A802
        for <netfilter-devel@vger.kernel.org>; Mon, 18 Jul 2022 04:32:33 -0700 (PDT)
Date:   Mon, 18 Jul 2022 13:32:30 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] parser_bison: bail out on too long names
Message-ID: <YtVEzsOM4VxFW4An@salvia>
References: <20220716080549.162980-1-pablo@netfilter.org>
 <YtKnbGh/FdJHlil3@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YtKnbGh/FdJHlil3@orbyte.nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Jul 16, 2022 at 01:56:28PM +0200, Phil Sutter wrote:
> Hi,
> 
> On Sat, Jul 16, 2022 at 10:05:49AM +0200, Pablo Neira Ayuso wrote:
> > If user specifies a too long object name, bail out.
> 
> Shouldn't this be done in eval phase or so? As-is, this patch introduces
> a standard syntax-specific limitation people may circumvent using JSON,
> no?

I can do it from eval phase. I will have to add more eval functions
though, because eval is not always called from for every command.
