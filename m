Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8173FAF2F
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 Aug 2021 02:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhH3ARS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 29 Aug 2021 20:17:18 -0400
Received: from mail.netfilter.org ([217.70.188.207]:38472 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhH3ARR (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 29 Aug 2021 20:17:17 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 77EA460201;
        Mon, 30 Aug 2021 02:15:25 +0200 (CEST)
Date:   Mon, 30 Aug 2021 02:16:21 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH libnetfilter_log 0/6] Implementation of some fields
 omitted by `ipulog_get_packet`.
Message-ID: <20210830001621.GA15908@salvia>
References: <20210828193824.1288478-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210828193824.1288478-1-jeremy@azazel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Aug 28, 2021 at 08:38:18PM +0100, Jeremy Sowden wrote:
> The first four patches contain some miscellaneous improvements, then the
> last two add code to retrieve time-stamps and interface names from
> packets.

Applied, thanks.

> Incidentally, I notice that the last release of libnetfilter_log was in
> 2012.  Time for 1.0.2, perhaps?

I'll prepare for release, thanks for signalling.
