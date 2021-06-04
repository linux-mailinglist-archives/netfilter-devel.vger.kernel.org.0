Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD3B39B587
	for <lists+netfilter-devel@lfdr.de>; Fri,  4 Jun 2021 11:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhFDJLf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 4 Jun 2021 05:11:35 -0400
Received: from mail.netfilter.org ([217.70.188.207]:46748 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhFDJLe (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 4 Jun 2021 05:11:34 -0400
Received: from netfilter.org (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 9CBA9641DB;
        Fri,  4 Jun 2021 11:08:39 +0200 (CEST)
Date:   Fri, 4 Jun 2021 11:09:45 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next] netfilter: nf_tables: add last expression
Message-ID: <20210604090945.GA25343@salvia>
References: <20210603233831.21962-1-pablo@netfilter.org>
 <20210604054849.GB32304@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210604054849.GB32304@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Jun 04, 2021 at 07:48:49AM +0200, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > Add a new optional expression that allows you to know when last match on
> > a given rule / set element.
> 
> I think this is small enough to build this into nf_tables itself rather
> than a module.

I'll make it built-in.
