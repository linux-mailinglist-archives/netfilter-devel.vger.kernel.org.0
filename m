Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 833AE2CB22
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 May 2019 18:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfE1QJS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 28 May 2019 12:09:18 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:37914 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfE1QJS (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 28 May 2019 12:09:18 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hVef7-0005xE-94; Tue, 28 May 2019 18:09:17 +0200
Date:   Tue, 28 May 2019 18:09:17 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Shekhar Sharma <shekhar250198@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft v3]tests: py: add netns feature
Message-ID: <20190528160917.GC21440@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Shekhar Sharma <shekhar250198@gmail.com>,
        netfilter-devel@vger.kernel.org
References: <20190528002113.7233-1-shekhar250198@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528002113.7233-1-shekhar250198@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Tue, May 28, 2019 at 05:51:13AM +0530, Shekhar Sharma wrote:
> This patch adds the netns feature to the 'nft-test.py' file.

This patch does more than that. It seems you've mixed the netns support
enhancement with Python3 compatibility enablement. Could you please
split these into two patches for easier review? Being able to clearly
see what has been done to enable netns support will be helpful later
when scrolling through git history, too.

Thanks, Phil
