Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F3F3DD610
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Aug 2021 14:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbhHBMzA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Aug 2021 08:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbhHBMzA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Aug 2021 08:55:00 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67985C06175F
        for <netfilter-devel@vger.kernel.org>; Mon,  2 Aug 2021 05:54:50 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1mAXSy-0007LL-Aq; Mon, 02 Aug 2021 14:54:48 +0200
Date:   Mon, 2 Aug 2021 14:54:48 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] ebtables: Dump atomic waste
Message-ID: <20210802125448.GX3673@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20210730103715.20501-1-phil@nwl.cc>
 <20210802090404.GA1252@salvia>
 <20210802110555.GW3673@orbyte.nwl.cc>
 <20210802115127.GA29324@salvia>
 <20210802115902.GA29377@salvia>
 <20210802115930.GA29440@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802115930.GA29440@salvia>
Sender:  <n0-1@orbyte.nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Aug 02, 2021 at 01:59:30PM +0200, Pablo Neira Ayuso wrote:
> On Mon, Aug 02, 2021 at 01:59:02PM +0200, Pablo Neira Ayuso wrote:
> > offlist
> 
> actually not :)

:D

The file is written by store_table_in_file() in communication.c, writing
a struct ebt_replace plus a number of struct ebt_entries. At this point
I stopped, assuming that translating back and forth would involve too
much legacy cruft.

Cheers, Phil
