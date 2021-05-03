Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A7537222A
	for <lists+netfilter-devel@lfdr.de>; Mon,  3 May 2021 23:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhECVCt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 3 May 2021 17:02:49 -0400
Received: from mail.netfilter.org ([217.70.188.207]:41006 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhECVCs (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 3 May 2021 17:02:48 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 7722E63087;
        Mon,  3 May 2021 23:01:11 +0200 (CEST)
Date:   Mon, 3 May 2021 23:01:51 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org, Jan Engelhardt <jengelh@inai.de>
Subject: Re: [net-next PATCH v2] netfilter: xt_SECMARK: add new revision to
 fix structure layout
Message-ID: <20210503210151.GA13380@salvia>
References: <20210430120013.28875-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210430120013.28875-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Apr 30, 2021 at 02:00:13PM +0200, Phil Sutter wrote:
> From: Pablo Neira Ayuso <pablo@netfilter.org>
> 
> This extension breaks when trying to delete rules, add a new revision to
> fix this.

Applied, thanks Phil.

I'm routing this through nf.git given removal of SECMARK rules is not
possible, which is a bug.

> Fixes: 5e6874cdb8de ("[SECMARK]: Add xtables SECMARK target")
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> Signed-off-by: Phil Sutter <phil@nwl.cc>
