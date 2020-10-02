Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6189128114B
	for <lists+netfilter-devel@lfdr.de>; Fri,  2 Oct 2020 13:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387756AbgJBLe1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 2 Oct 2020 07:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgJBLe1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 2 Oct 2020 07:34:27 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBFBC0613D0
        for <netfilter-devel@vger.kernel.org>; Fri,  2 Oct 2020 04:34:26 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1kOJKS-00082U-Px; Fri, 02 Oct 2020 13:34:24 +0200
Date:   Fri, 2 Oct 2020 13:34:24 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Arturo Borrero Gonzalez <arturo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] nft: Optimize class-based IP prefix matches
Message-ID: <20201002113424.GA29050@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Arturo Borrero Gonzalez <arturo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20201002090334.29788-1-phil@nwl.cc>
 <9c63d7a4-c034-5c38-842d-f262d9db8fa7@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c63d7a4-c034-5c38-842d-f262d9db8fa7@netfilter.org>
Sender:  <n0-1@orbyte.nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Oct 02, 2020 at 01:25:37PM +0200, Arturo Borrero Gonzalez wrote:
> On 2020-10-02 11:03, Phil Sutter wrote:
> > +#define max(x, y) ((x) > (y) ? (x) : (y))
> 
> This is unused, right? not sure if on purpose.

Ah yes, I felt like adding it while being at it. Fine with you or should
I drop it?

Thanks for reviewing!

Phil
