Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0839447660B
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Dec 2021 23:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhLOWl4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 Dec 2021 17:41:56 -0500
Received: from mail.netfilter.org ([217.70.188.207]:56256 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhLOWlx (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:41:53 -0500
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 75A01625C5;
        Wed, 15 Dec 2021 23:39:24 +0100 (CET)
Date:   Wed, 15 Dec 2021 23:41:48 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH v2 4/6] xtables_globals: Introduce
 program_variant
Message-ID: <YbpvLPEatqIKqhym@salvia>
References: <20211213180747.20707-1-phil@nwl.cc>
 <20211213180747.20707-5-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211213180747.20707-5-phil@nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Dec 13, 2021 at 07:07:45PM +0100, Phil Sutter wrote:
> This is supposed to hold the variant name (either "legacy" or
> "nf_tables") for use in shared help/error printing functions.

Only one more nitpick: Probably you can store this in program_version?
It is also string then this skips the binary layout update of
xtables_globals.

.program_version = PACKAGE_VERSION VARIANT,

where VARIANT is " legacy" or " nf_tables".

Apart from this, this batch LGTM, thanks.
