Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D60447E65
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Nov 2021 12:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbhKHLFd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 8 Nov 2021 06:05:33 -0500
Received: from mail.netfilter.org ([217.70.188.207]:47032 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbhKHLFd (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 8 Nov 2021 06:05:33 -0500
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 7DE2D6063C;
        Mon,  8 Nov 2021 12:00:49 +0100 (CET)
Date:   Mon, 8 Nov 2021 12:02:42 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] Unbreak xtables-translate
Message-ID: <YYkD0roNztmDLPHp@salvia>
References: <20211106204544.13136-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211106204544.13136-1-phil@nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Nov 06, 2021 at 09:45:44PM +0100, Phil Sutter wrote:
> Fixed commit broke xtables-translate which still relied upon do_parse()
> to properly initialize the passed iptables_command_state reference. To
> allow for callers to preset fields, this doesn't happen anymore so
> do_command_xlate() has to initialize itself. Otherwise garbage from
> stack is read leading to segfaults and program aborts.
> 
> Although init_cs callback is used by arptables only and
> arptables-translate has not been implemented, do call it if set just to
> avoid future issues.
> 
> Fixes: cfdda18044d81 ("nft-shared: Introduce init_cs family ops callback")
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Tested-by: Pablo Neira Ayuso <pablo@netfilter.org>

