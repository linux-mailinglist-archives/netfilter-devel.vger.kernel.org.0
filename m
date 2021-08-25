Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5022B3F6F2D
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Aug 2021 08:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237913AbhHYGKz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 25 Aug 2021 02:10:55 -0400
Received: from mail.netfilter.org ([217.70.188.207]:49984 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237908AbhHYGKz (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 25 Aug 2021 02:10:55 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 4970C600E0
        for <netfilter-devel@vger.kernel.org>; Wed, 25 Aug 2021 08:09:15 +0200 (CEST)
Date:   Wed, 25 Aug 2021 08:10:05 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Netfilter Development <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH libnetfilter_queue v4 3/4] build: doc: VPATH builds work
 again
Message-ID: <20210825061005.GB818@salvia>
References: <20210822041442.8394-1-duncan_roe@optusnet.com.au>
 <20210822041442.8394-3-duncan_roe@optusnet.com.au>
 <20210824102840.GA30322@salvia>
 <YSWjkN/8Bp23ZITM@slk1.local.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YSWjkN/8Bp23ZITM@slk1.local.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Aug 25, 2021 at 11:57:36AM +1000, Duncan Roe wrote:
> On Tue, Aug 24, 2021 at 12:28:40PM +0200, Pablo Neira Ayuso wrote:
> > On Sun, Aug 22, 2021 at 02:14:41PM +1000, Duncan Roe wrote:
> > > Also get make distcleancheck to pass (only applies to VPATH builds).
> >
> > Not sure I follow. What commit broke this?
> 
> No idea. make distcleancheck fails in current master. Never tested it before.
>                   ^^^^^

Oh, I see, then please add this to the patch description. I was not
understanding what was being fixed.

Thanks.
