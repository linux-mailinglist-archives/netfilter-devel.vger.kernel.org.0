Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2449C109DCB
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 Nov 2019 13:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbfKZMVO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 26 Nov 2019 07:21:14 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:46214 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728336AbfKZMVO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 26 Nov 2019 07:21:14 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iZZqA-00039O-Pe; Tue, 26 Nov 2019 13:21:10 +0100
Date:   Tue, 26 Nov 2019 13:21:10 +0100
From:   Florian Westphal <fw@strlen.de>
To:     "Serguei Bezverkhi (sbezverk)" <sbezverk@cisco.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
Subject: Re: Operation not supported when adding jump command
Message-ID: <20191126122110.GD795@breakpoint.cc>
References: <5248B312-60A9-48A7-B4CF-E00D1BDF1CD2@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5248B312-60A9-48A7-B4CF-E00D1BDF1CD2@cisco.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Serguei Bezverkhi (sbezverk) <sbezverk@cisco.com> wrote:
> Hello Pablo,
> 
> Please see below  table/chain/rules/sets I program,  when I try to add jump from input-net, input-local to services  it fails with " Operation not supported" , I would appreciate if somebody could help to understand why:
> 
> sudo nft add rule ipv4table input-net jump services
> Error: Could not process rule: Operation not supported
> add rule ipv4table input-net jump services
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

iirc "reject" only works in input/forward/postrouting hooks.
