Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD96130535
	for <lists+netfilter-devel@lfdr.de>; Sun,  5 Jan 2020 01:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgAEAlZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 4 Jan 2020 19:41:25 -0500
Received: from rain.florz.de ([185.139.32.146]:54129 "EHLO rain.florz.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgAEAlZ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 4 Jan 2020 19:41:25 -0500
Received: from [2a07:12c0:1c00:43::121] (port=59252 helo=florz.florz.de)
        by rain.florz.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA256:256)
        (Exim 4.92)
        (envelope-from <florz@florz.de>)
        id 1intys-00048A-FN
        for netfilter-devel@vger.kernel.org; Sun, 05 Jan 2020 01:41:22 +0100
Received: from florz by florz.florz.de with local (Exim 4.92)
        (envelope-from <florz@florz.de>)
        id 1intys-00057F-2X
        for netfilter-devel@vger.kernel.org; Sun, 05 Jan 2020 01:41:22 +0100
Date:   Sun, 5 Jan 2020 01:41:22 +0100
From:   Florian Zumbiehl <florz@florz.de>
To:     netfilter-devel@vger.kernel.org
Subject: [nftables] bug: prefix masks applied to set lookup keys are
 decompiled as a prefix length applied to the set
Message-ID: <20200105004121.GE3854@florz.florz.de>
Mail-Followup-To: netfilter-devel@vger.kernel.org, florz@florz.de
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

I stumbled upon another bug in the Debian buster backports version of nftables:

| # nft 'table ip foobartest { chain c { ip saddr & 0.0.0.0 { 0.0.0.0 }; }; }' 
| # nft list table ip foobartest
| table ip foobartest {
|         chain c {
|                 ip saddr { 0.0.0.0 }/0
|         }
| }

That prefix length suffix after the set both looks a bit strange and
doesn't seem to be valid nft input syntax, so I guess that makes it a bug?

My guess is that the cause is the second case in
relational_binop_postprocess(), which doesn't seem to check for the type of
the right operand?

Regards, Florian
