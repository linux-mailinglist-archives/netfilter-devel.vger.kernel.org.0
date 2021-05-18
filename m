Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2726C387D04
	for <lists+netfilter-devel@lfdr.de>; Tue, 18 May 2021 18:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350080AbhERQCX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 18 May 2021 12:02:23 -0400
Received: from mail.netfilter.org ([217.70.188.207]:43130 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350232AbhERQCX (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 18 May 2021 12:02:23 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 3793964174;
        Tue, 18 May 2021 18:00:09 +0200 (CEST)
Date:   Tue, 18 May 2021 18:01:01 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [net-next PATCH] net: netfilter: nft_exthdr: Support SCTP chunks
Message-ID: <20210518160101.GA24285@salvia>
References: <20210504155406.17150-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210504155406.17150-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, May 04, 2021 at 05:54:06PM +0200, Phil Sutter wrote:
> Chunks are SCTP header extensions similar in implementation to IPv6
> extension headers or TCP options. Reusing exthdr expression to find and
> extract field values from them is therefore pretty straightforward.
> 
> For now, this supports extracting data from chunks at a fixed offset
> (and length) only - chunks themselves are an extensible data structure;
> in order to make all fields available, a nested extension search is
> needed.

Applied, thanks.
