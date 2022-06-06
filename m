Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCA453ECC1
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 Jun 2022 19:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiFFRM4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 6 Jun 2022 13:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiFFRMo (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 6 Jun 2022 13:12:44 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38C36275EB;
        Mon,  6 Jun 2022 10:01:14 -0700 (PDT)
Date:   Mon, 6 Jun 2022 19:01:11 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        netfilter-devel@vger.kernel.org, linux-spdx@vger.kernel.org,
        Manoj Basapathi <manojbm@codeaurora.org>,
        Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
Subject: Re: netfilter: xtables: Bring SPDX identifier back
Message-ID: <Yp4y19o3EnRE+f7r@salvia>
References: <87ee016cji.ffs@tglx>
 <Yp4eiv4xUhWc2VEx@salvia>
 <Yp4xrPVwI8g7glwr@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yp4xrPVwI8g7glwr@kroah.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jun 06, 2022 at 06:56:12PM +0200, Greg KH wrote:
> On Mon, Jun 06, 2022 at 05:34:34PM +0200, Pablo Neira Ayuso wrote:
> > On Mon, Jun 06, 2022 at 05:23:45PM +0200, Thomas Gleixner wrote:
> > > Commit e2be04c7f995 ("License cleanup: add SPDX license identifier to
> > > uapi header files with a license") added the correct SPDX identifier to
> > > include/uapi/linux/netfilter/xt_IDLETIMER.h.
> > > 
> > > A subsequent commit removed it for no reason and reintroduced the UAPI
> > > license incorrectness as the file is now missing the UAPI exception
> > > again.
> > > 
> > > Add it back and remove the GPLv2 boilerplate while at it.
> > 
> > LGTM.
> > 
> > You handle this or I place this in the nf.git tree?
> 
> If you want to take it, that's fine with me, otherwise I can in a
> spdx-specific tree that I manage.

I did not know there is a specific tree for this.

> Your choice, which ever is easier for you.

please take it
