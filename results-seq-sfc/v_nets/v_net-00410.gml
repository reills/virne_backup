graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 410
  arrival_time 8099.743252680189
  lifetime 186.6443532317569
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 34
    rom 7
  ]
  node [
    id 1
    label "1"
    cpu 21
    gpu 2
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 29
    gpu 12
    rom 14
  ]
  node [
    id 3
    label "3"
    cpu 11
    gpu 43
    rom 22
  ]
  node [
    id 4
    label "4"
    cpu 40
    gpu 9
    rom 30
  ]
  edge [
    source 0
    target 1
    bw 11
  ]
  edge [
    source 1
    target 2
    bw 17
  ]
  edge [
    source 2
    target 3
    bw 37
  ]
  edge [
    source 3
    target 4
    bw 6
  ]
]
