Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58E1C5734D
	for <lists+netfilter-devel@lfdr.de>; Wed, 26 Jun 2019 23:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfFZVHV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 26 Jun 2019 17:07:21 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:43492 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726227AbfFZVHV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 26 Jun 2019 17:07:21 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hgF8S-000692-Cm; Wed, 26 Jun 2019 23:07:20 +0200
Date:   Wed, 26 Jun 2019 23:07:20 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Ander Juaristi <a@juaristi.eus>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] nftables: meta: hour: Fix integer overflow error
Message-ID: <20190626210720.iel4t4ifgbc5kz4d@breakpoint.cc>
References: <20190626204402.5257-1-a@juaristi.eus>
 <20190626204402.5257-2-a@juaristi.eus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626204402.5257-2-a@juaristi.eus>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Ander Juaristi <a@juaristi.eus> wrote:
> This patch fixes an overflow error that would happen when introducing edge times
> whose second representation is smaller than the value of the tm_gmtoff field, such
> as 00:00.

I think you can squash this with the earlier patch, unless you think
its worth to record this in git?
