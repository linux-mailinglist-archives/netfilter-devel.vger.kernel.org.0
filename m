Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BF23BC2C0
	for <lists+netfilter-devel@lfdr.de>; Mon,  5 Jul 2021 20:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhGESih (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 5 Jul 2021 14:38:37 -0400
Received: from mail.netfilter.org ([217.70.188.207]:48536 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhGESig (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 5 Jul 2021 14:38:36 -0400
Received: from netfilter.org (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id E57AC61653;
        Mon,  5 Jul 2021 20:35:47 +0200 (CEST)
Date:   Mon, 5 Jul 2021 20:35:55 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next] include: fix header file name in 3 comments
Message-ID: <20210705183555.GA10944@salvia>
References: <20210705123829.10090-1-duncan_roe@optusnet.com.au>
 <20210705183435.GA10889@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210705183435.GA10889@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jul 05, 2021 at 08:34:35PM +0200, Pablo Neira Ayuso wrote:
> net-next is still closed (so it is nf-next too), but I'll keep this
> patch in patchwork until it opens up again.

Thinking it well, I can take this small fix to nf instead of nf-next,
so this fix propagates swifly upstream.

Thanks.
