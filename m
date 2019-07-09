Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48F156371E
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Jul 2019 15:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfGINjq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 9 Jul 2019 09:39:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33089 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfGINjp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 9 Jul 2019 09:39:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so21125089wru.0
        for <netfilter-devel@vger.kernel.org>; Tue, 09 Jul 2019 06:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=apoOMffNJoQn70AP+vwaQWCqZ67b11ZTTTPNPF0zncc=;
        b=low1tkX+u0lmbS53jGQMF39lCRHPF4OmP0atVBomBggFXnzvLKyRf94mZxIe074Pcm
         YsVhjy3HsTU79H83cps/H9wRxNdKJgTMhWQsyii4YVxz61gBKdPqu6Ntjvf/3cz854r9
         iqY6UJycGQQ2Q5b+cC9Cw2Mw+QT5HUNSg590fCqW3FDDdhJ6EV0aBpbkh3VONpJOgDY9
         v/VVok38LDTXBXy1lkMMSUYhKDE/9Ungavt6a4DPdqUT5xrnFIH3s5OeFekiPl/jmBr0
         9xVdMuuau0ikX90ueNGoO0NVnRJIfePLA+wWcjGYNpsox/bomBnjmEMOLWScBVrTEBEj
         My8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=apoOMffNJoQn70AP+vwaQWCqZ67b11ZTTTPNPF0zncc=;
        b=XdUoV14PK8c5AMZpIgKwUrLKkayQ+b3QPHvVUwst3b3XPlw8aFOzMCAxUijsS6Rv4G
         RusHfCDkHwT1CQFEO+aTfouzj+AHD/6d7bFmpYgpMh2dnMIKfSrJDZbmdnQ307tHQE6u
         QCgp5xdlPSVUVp58g/p8ReRuZUlS/a1Lk0vjU/HZN5W/g2jl0qiABWlccGEO92jvJYpD
         mXcoLiUO7YmHdq+nOuVmSkq9hpeofAt4whu41LBY9BeHroY3C9KYyCztMI4HKwdXiQBg
         ZY+nZAcmgzsPgOESdw6xwI1Cc4qiy6nbO8fzvnjg88D7YElAFwWP0v32mjT5RTdAX22o
         5GYA==
X-Gm-Message-State: APjAAAVpfyW3ihqMvwSDvHmMEXaMTRM3q4kmR+HUqDflNyloEP72IPfo
        swBiPVChJJAS2njiPvM9+mQkBQ==
X-Google-Smtp-Source: APXvYqzx7x4PaqGGI3lQwjrwx1jljBVsRO2D7YzozT/qbBkMF/u153y1W2UIg60XDmesJBx4LOE/7Q==
X-Received: by 2002:adf:f646:: with SMTP id x6mr21117021wrp.18.1562679584114;
        Tue, 09 Jul 2019 06:39:44 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id z25sm3598235wmf.38.2019.07.09.06.39.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 06:39:43 -0700 (PDT)
Date:   Tue, 9 Jul 2019 15:39:43 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netdev@vger.kernel.org, davem@davemloft.net,
        thomas.lendacky@amd.com, f.fainelli@gmail.com,
        ariel.elior@cavium.com, michael.chan@broadcom.com,
        madalin.bucur@nxp.com, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, jeffrey.t.kirsher@intel.com,
        tariqt@mellanox.com, saeedm@mellanox.com, jiri@mellanox.com,
        idosch@mellanox.com, jakub.kicinski@netronome.com,
        peppe.cavallaro@st.com, grygorii.strashko@ti.com, andrew@lunn.ch,
        vivien.didelot@gmail.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, linux-net-drivers@solarflare.com,
        ogerlitz@mellanox.com, Manish.Chopra@cavium.com,
        marcelo.leitner@gmail.com, mkubecek@suse.cz,
        venkatkumar.duvvuru@broadcom.com, maxime.chevallier@bootlin.com,
        cphealy@gmail.com, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH net-next,v3 10/11] net: flow_offload: add
 flow_block_cb_is_busy() and use it
Message-ID: <20190709133943.GC2301@nanopsycho.orion>
References: <20190708160614.2226-1-pablo@netfilter.org>
 <20190708160614.2226-11-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708160614.2226-11-pablo@netfilter.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Mon, Jul 08, 2019 at 06:06:12PM CEST, pablo@netfilter.org wrote:

[...]

>+bool flow_block_cb_is_busy(tc_setup_cb_t *cb, void *cb_ident,

There should be another patch before this one renaming tc_setup_cb_t and
ndo_setup_tc. This is not TC specific anymore now, it might confuse the
reader.

[...]
