Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3ACE5BA78E
	for <lists+netfilter-devel@lfdr.de>; Fri, 16 Sep 2022 09:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiIPHmM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 16 Sep 2022 03:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIPHmL (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 16 Sep 2022 03:42:11 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9328A2227
        for <netfilter-devel@vger.kernel.org>; Fri, 16 Sep 2022 00:42:09 -0700 (PDT)
Date:   Fri, 16 Sep 2022 09:42:06 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     netfilter-devel@vger.kernel.org,
        Peter Collinson <pc@hillside.co.uk>
Subject: Re: [PATCH 1/3 nft] py: extend python API to support libnftables API
Message-ID: <YyQozr4uC0RWrflJ@salvia>
References: <20220912105225.79025-1-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220912105225.79025-1-ffmancera@riseup.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Sep 12, 2022 at 12:52:23PM +0200, Fernando Fernandez Mancera wrote:
> From: Peter Collinson <pc@hillside.co.uk>
> 
> Allows py/nftables.py to support full mapping to the libnftables API. The
> changes allow python code to talk in text to the kernel rather than just
> using json. The Python API can now also use dry run to test changes.

Series, applied.
