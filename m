Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2C538ECE7
	for <lists+netfilter-devel@lfdr.de>; Mon, 24 May 2021 17:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbhEXP3t (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 24 May 2021 11:29:49 -0400
Received: from mail.netfilter.org ([217.70.188.207]:58538 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbhEXP1x (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 24 May 2021 11:27:53 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id E0C90641DB;
        Mon, 24 May 2021 17:25:24 +0200 (CEST)
Date:   Mon, 24 May 2021 17:26:21 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Thomas De Schampheleire <patrickdepinguin@gmail.com>
Cc:     netfilter-devel@vger.kernel.org, thomas.de_schampheleire@nokia.com
Subject: Re: [ebtables PATCH 2/2] configure.ac: add option
 --enable-kernel-64-userland-32
Message-ID: <20210524152621.GA21404@salvia>
References: <20210518181730.13436-1-patrickdepinguin@gmail.com>
 <20210518181730.13436-2-patrickdepinguin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210518181730.13436-2-patrickdepinguin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, May 18, 2021 at 08:17:30PM +0200, Thomas De Schampheleire wrote:
> From: Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>
> 
> The ebtables build system seems to assume that 'sparc64' is the
> only case where KERNEL_64_USERSPACE_32 is relevant, but this is not true.
> This situation can happen on many architectures, especially in embedded
> systems. For example, an Aarch64 processor with kernel in 64-bit but
> userland built for 32-bit Arm. Or a 64-bit MIPS Octeon III processor, with
> userland running in the 'n32' ABI.
> 
> While it is possible to set CFLAGS in the environment when calling the
> configure script, the caller would need to know to not only specify
> KERNEL_64_USERSPACE_32 but also the EBT_MIN_ALIGN value.
> 
> Instead, add a configure option. All internal details can then be handled by
> the configure script.

Are you enabling

CONFIG_NETFILTER_XTABLES_COMPAT

in your kernel build?

KERNEL_64_USERSPACE_32 was deprecated long time ago in favour of
CONFIG_NETFILTER_XTABLES_COMPAT.
