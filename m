Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBB23DD29B
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Aug 2021 11:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbhHBJEX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Aug 2021 05:04:23 -0400
Received: from mail.netfilter.org ([217.70.188.207]:49244 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbhHBJEW (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:04:22 -0400
Received: from netfilter.org (bl11-146-165.dsl.telepac.pt [85.244.146.165])
        by mail.netfilter.org (Postfix) with ESMTPSA id 18C3360037;
        Mon,  2 Aug 2021 11:03:36 +0200 (CEST)
Date:   Mon, 2 Aug 2021 11:04:04 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] ebtables: Dump atomic waste
Message-ID: <20210802090404.GA1252@salvia>
References: <20210730103715.20501-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210730103715.20501-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Phil,

On Fri, Jul 30, 2021 at 12:37:15PM +0200, Phil Sutter wrote:
> With ebtables-nft.8 now educating people about the missing
> functionality, get rid of atomic remains in source code. This eliminates
> mostly comments except for --atomic-commit which was treated as alias of
> --init-table. People not using the latter are probably trying to
> atomic-commit from an atomic-file which in turn is not supported, so no
> point keeping it.

That's fine.

If there's any need in the future for emulating this in the future, it
should be possible to map atomic-save to ebtables-save and
atomic-commit to ebtables-restore.

Anyway, this one of the exotic options in ebtables that makes it
different from ip,ip6,arptables. Given there are better tools now that
are aligned with the more orthodox approach, this should be OK.

Thanks.
