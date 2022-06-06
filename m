Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DAB53E93D
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 Jun 2022 19:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240912AbiFFPex (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 6 Jun 2022 11:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240842AbiFFPej (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:34:39 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DFFEF35AA7;
        Mon,  6 Jun 2022 08:34:37 -0700 (PDT)
Date:   Mon, 6 Jun 2022 17:34:34 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     netfilter-devel@vger.kernel.org, linux-spdx@vger.kernel.org,
        Manoj Basapathi <manojbm@codeaurora.org>,
        Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
Subject: Re: netfilter: xtables: Bring SPDX identifier back
Message-ID: <Yp4eiv4xUhWc2VEx@salvia>
References: <87ee016cji.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ee016cji.ffs@tglx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jun 06, 2022 at 05:23:45PM +0200, Thomas Gleixner wrote:
> Commit e2be04c7f995 ("License cleanup: add SPDX license identifier to
> uapi header files with a license") added the correct SPDX identifier to
> include/uapi/linux/netfilter/xt_IDLETIMER.h.
> 
> A subsequent commit removed it for no reason and reintroduced the UAPI
> license incorrectness as the file is now missing the UAPI exception
> again.
> 
> Add it back and remove the GPLv2 boilerplate while at it.

LGTM.

You handle this or I place this in the nf.git tree?

Thanks
