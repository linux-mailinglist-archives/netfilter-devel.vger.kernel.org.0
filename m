Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 702D158157
	for <lists+netfilter-devel@lfdr.de>; Thu, 27 Jun 2019 13:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfF0LVK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 27 Jun 2019 07:21:10 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:47228 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726308AbfF0LVK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 27 Jun 2019 07:21:10 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hgSSj-0002Q5-HB; Thu, 27 Jun 2019 13:21:09 +0200
Date:   Thu, 27 Jun 2019 13:21:09 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Arturo Borrero Gonzalez <arturo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 3/3] libnftables: export public symbols only
Message-ID: <20190627112109.vhbvx2fsisutgqgf@breakpoint.cc>
References: <156163260014.22035.13586288868224137755.stgit@endurance>
 <156163261833.22035.12433880743521864302.stgit@endurance>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156163261833.22035.12433880743521864302.stgit@endurance>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Arturo Borrero Gonzalez <arturo@netfilter.org> wrote:
> Export public symbols (the library API functions) instead of all symbols in
> the library.

\o/

This is long overdue, thanks for doing this Arturo!
