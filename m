Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D777447DE6
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Nov 2021 11:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbhKHK3J (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 8 Nov 2021 05:29:09 -0500
Received: from mail.netfilter.org ([217.70.188.207]:46770 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237552AbhKHK2s (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:28:48 -0500
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 2A3166063C;
        Mon,  8 Nov 2021 11:24:05 +0100 (CET)
Date:   Mon, 8 Nov 2021 11:25:59 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] selftests: netfilter: extend nfqueue tests to cover
 vrf device
Message-ID: <YYj7N5Hppz3I2mAp@salvia>
References: <20211020162537.11361-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211020162537.11361-1-fw@strlen.de>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Oct 20, 2021 at 06:25:37PM +0200, Florian Westphal wrote:
> VRF device calls the output/postrouting hooks so packet should be seeon
> with oifname tvrf and once with eth0.

Applied, thanks.
