Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF0349D5E9
	for <lists+netfilter-devel@lfdr.de>; Thu, 27 Jan 2022 00:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbiAZXIc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 26 Jan 2022 18:08:32 -0500
Received: from mail.netfilter.org ([217.70.188.207]:58508 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiAZXIc (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:08:32 -0500
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id E8C9C60676;
        Thu, 27 Jan 2022 00:05:26 +0100 (CET)
Date:   Thu, 27 Jan 2022 00:08:25 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] selftests: netfilter: reduce zone stress test running
 time
Message-ID: <YfHUaXfvfGStxaNA@salvia>
References: <20220123144554.567444-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220123144554.567444-1-fw@strlen.de>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Jan 23, 2022 at 03:45:54PM +0100, Florian Westphal wrote:
> This selftests needs almost 3 minutes to complete, reduce the
> insertes zones to 1000.  Test now completes in about 20 seconds.

Applied, thanks
