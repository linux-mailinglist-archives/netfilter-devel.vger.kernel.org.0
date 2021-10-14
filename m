Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335FF42E31D
	for <lists+netfilter-devel@lfdr.de>; Thu, 14 Oct 2021 23:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbhJNVMK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 14 Oct 2021 17:12:10 -0400
Received: from mail.netfilter.org ([217.70.188.207]:47302 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhJNVMJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 14 Oct 2021 17:12:09 -0400
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id B5F6C60056;
        Thu, 14 Oct 2021 23:08:25 +0200 (CEST)
Date:   Thu, 14 Oct 2021 23:10:00 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] selftests: netfilter: remove stray bash debug line
Message-ID: <YWicqMtWt6d+B0WP@salvia>
References: <20211012163709.9819-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211012163709.9819-1-fw@strlen.de>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Oct 12, 2021 at 06:37:09PM +0200, Florian Westphal wrote:
> This should not be there.

Applied, thanks
