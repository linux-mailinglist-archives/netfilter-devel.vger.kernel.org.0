Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFB2658155
	for <lists+netfilter-devel@lfdr.de>; Thu, 27 Jun 2019 13:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfF0LU2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 27 Jun 2019 07:20:28 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:47224 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726308AbfF0LU2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 27 Jun 2019 07:20:28 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hgSS2-0002Pk-AC; Thu, 27 Jun 2019 13:20:26 +0200
Date:   Thu, 27 Jun 2019 13:20:26 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Arturo Borrero Gonzalez <arturo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 1/3] nft: use own allocation function
Message-ID: <20190627112026.vbvmz7j3dmz5pdvm@breakpoint.cc>
References: <156163260014.22035.13586288868224137755.stgit@endurance>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156163260014.22035.13586288868224137755.stgit@endurance>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Arturo Borrero Gonzalez <arturo@netfilter.org> wrote:
> In the current setup, nft (the frontend object) is using the xzalloc() function
> from libnftables, which does not makes sense, as this is typically an internal
> helper function.
> 
> In order to don't use this public libnftables symbol (a later patch just
> removes it), let's introduce a new allocation function in the nft frontend.
> This results in a bit of code duplication, but given the simplicity of the code,
> I don't think it's a big deal.
> 
> Other possible approach would be to have xzalloc() become part of libnftables
> public API, but that is a much worse scenario I think.

Agree, thus:

Acked-by: Florian Westphal <fw@strlen.de>
