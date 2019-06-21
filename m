Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 474E74EBC5
	for <lists+netfilter-devel@lfdr.de>; Fri, 21 Jun 2019 17:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfFUPTa (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 21 Jun 2019 11:19:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39962 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfFUPTa (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:19:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id p11so6960774wre.7
        for <netfilter-devel@vger.kernel.org>; Fri, 21 Jun 2019 08:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3VbzSB5yjaWLuskB1X5KhErGhgQBo8TZe9ClLCDNvO8=;
        b=gJQ2uBPnHJjzvdAqxeUsYwzMBXQNFRmJGysF4PhRRXj1N7M08zil1kDmCYId7ChgTy
         YCQwRA66ur8Jn6tz5yK5+fTy8xjO3VuCx9+MtPjyyDA91rw0LZu/5QQ8pHOXbOKgb68p
         tvFJzqihOuqvtKkxYIvnQJeTIrRp5iNMG/Z0XlixJN60go1kT64511pMV2nLRvUDWthZ
         cKd5T7CO/bD6lhn4yFP5rZDqNIZDHrRYahQ/oqWoAddQcv3C9WkqfFy3hD7VxMSWyXnq
         CY46AVVJZhYLRIU1fSHc7VZZRKhrfdk3zpAGboWzTYVMwSZC63cWAUZZnC64Cgtxh6bz
         6ncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3VbzSB5yjaWLuskB1X5KhErGhgQBo8TZe9ClLCDNvO8=;
        b=WhcrAL/fyyietl2eUxy4xHCJ5rJUCFxPud7tuC3nWvW98JET0UEQt2K0etb6RylwVY
         56JBzX0nj3vQMICxFSJMtFzaNR4w6D3jqYGYO7rqWARQuc+K/qBzh7dvnFo1Rg8tDN77
         xAybTFrxQpd4FAAmjQcpWy0RACPFZTUPOb5Yj+r8tAg86PvZ+1ralNixSMHg+opZaHo5
         9BU+WUOZY90JE2KwOhNscvRwr0vsG1YfIJTki30zI36uEMjdq7UXkb7wG4+g7pLoA+b6
         DV19zGmpeTLZkHdAmiMnefi1OwjV1RHAKb1WLh32kn2D+wTpk56jyhmRF0d4SGo5zvSS
         nI0Q==
X-Gm-Message-State: APjAAAUs53EyktXlM44q3ag8UWK3J9kpRRjGqaz7LkRIpFCPbGWM4NF7
        64D7JmMijVZFM62PSCNkFjp7Gw==
X-Google-Smtp-Source: APXvYqzW3VtV8IUseUl13rO/O/bJcMZ87gCzy5RXZirZEP0WAh788Mbt9OB81YzwihqnHsYgNU8aYQ==
X-Received: by 2002:adf:afe8:: with SMTP id y40mr17211181wrd.328.1561130368127;
        Fri, 21 Jun 2019 08:19:28 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id p3sm1947749wrd.47.2019.06.21.08.19.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 08:19:27 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:19:27 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        davem@davemloft.net, thomas.lendacky@amd.com, f.fainelli@gmail.com,
        ariel.elior@cavium.com, michael.chan@broadcom.com,
        santosh@chelsio.com, madalin.bucur@nxp.com,
        yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        jeffrey.t.kirsher@intel.com, tariqt@mellanox.com,
        saeedm@mellanox.com, jiri@mellanox.com, idosch@mellanox.com,
        jakub.kicinski@netronome.com, peppe.cavallaro@st.com,
        grygorii.strashko@ti.com, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, linux-net-drivers@solarflare.com,
        ganeshgr@chelsio.com, ogerlitz@mellanox.com,
        Manish.Chopra@cavium.com, marcelo.leitner@gmail.com,
        mkubecek@suse.cz, venkatkumar.duvvuru@broadcom.com,
        cphealy@gmail.com
Subject: Re: [PATCH net-next 10/12] net: flow_offload: add flow_block_cb API
Message-ID: <20190621151927.GB2414@nanopsycho.orion>
References: <20190620194917.2298-1-pablo@netfilter.org>
 <20190620194917.2298-11-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620194917.2298-11-pablo@netfilter.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Thu, Jun 20, 2019 at 09:49:15PM CEST, pablo@netfilter.org wrote:

[...]

>diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
>index 36127c1858a4..728ded7e4361 100644
>--- a/include/net/flow_offload.h
>+++ b/include/net/flow_offload.h
>@@ -232,4 +232,56 @@ static inline void flow_stats_update(struct flow_stats *flow_stats,
> 	flow_stats->lastused	= max_t(u64, flow_stats->lastused, lastused);
> }
> 
>+#include <net/sch_generic.h> /* for tc_setup_cb_t. */
>+
>+enum flow_block_command {
>+	TC_BLOCK_BIND,
>+	TC_BLOCK_UNBIND,

It's not TC now. You should name these FLOW_BLOCK_BIND/UNBIND


>+};
>+
>+enum flow_block_binder_type {
>+	TCF_BLOCK_BINDER_TYPE_UNSPEC,
>+	TCF_BLOCK_BINDER_TYPE_CLSACT_INGRESS,
>+	TCF_BLOCK_BINDER_TYPE_CLSACT_EGRESS,

Same here.

>+};
>+

[...]
