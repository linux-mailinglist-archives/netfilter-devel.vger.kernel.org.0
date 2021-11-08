Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E54D447DEF
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Nov 2021 11:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhKHKaZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 8 Nov 2021 05:30:25 -0500
Received: from mail.netfilter.org ([217.70.188.207]:46786 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbhKHKaZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:30:25 -0500
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id E266D6063C;
        Mon,  8 Nov 2021 11:25:40 +0100 (CET)
Date:   Mon, 8 Nov 2021 11:27:34 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [nf PATCH 0/2] Review port shadow selftest
Message-ID: <YYj7ljF/cAm7xsG3@salvia>
References: <20211103185343.28421-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211103185343.28421-1-phil@nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Nov 03, 2021 at 07:53:41PM +0100, Phil Sutter wrote:
> Trying the test on a local VM I noticed spurious errors from nc,
> complaining about an address being already in use. Patch 1 fixes this.
> Validating the notrack workaround led to the minor simplifications in
> patch 2.

Series applied, thanks.
