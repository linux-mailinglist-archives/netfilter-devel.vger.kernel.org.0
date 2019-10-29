Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 023DBE848F
	for <lists+netfilter-devel@lfdr.de>; Tue, 29 Oct 2019 10:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfJ2JkD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 29 Oct 2019 05:40:03 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:41928 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfJ2JkD (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:40:03 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iPNyq-0003DC-5G; Tue, 29 Oct 2019 10:40:00 +0100
Date:   Tue, 29 Oct 2019 10:40:00 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: libnftnl: Attribute and data length validation for objects
Message-ID: <20191029094000.GS26123@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

The plan is to deprecate all the "untyped setters" (i.e., most of
nftnl_*_set()) since they accept a data pointer without length so no
data length validation may happen.

In the same effort, said validation should be added where missing.

While working on this for objects, I noticed a potential problem with
nftnl_obj_set():

| void nftnl_obj_set(struct nftnl_obj *obj, uint16_t attr, const void *data)
| {
| 	nftnl_obj_set_data(obj, attr, data, nftnl_obj_validate[attr]);
| }

Callers pass some specific object's attribute to the function, e.g.
NFTNL_OBJ_QUOTA_FLAGS. Unless I miss something, this leads to
overstepping of nftnl_obj_validate array bounds which is defined with
a size of NFTNL_OBJ_MAX.

Anyway, when adding validation to the specific object types in
src/obj/*.c, I broke the above function since it passes bogus data_len.
The only way to keep this functional is to make max attr value and
validate array accessible from src/object.c, thereby performing the
validation for all object types in a common place.

Doing so I added 'uint32_t *validate' field to struct obj_ops and
assumed max_attr field is already what I need - which is wrong: max_attr
holds the max NFTA_* value, not NFTNL_OBJ_* one which I need.

Long story short: Should I add a new field or can I reuse max_attr which
apparently is otherwise unused?

Cheers, Phil
