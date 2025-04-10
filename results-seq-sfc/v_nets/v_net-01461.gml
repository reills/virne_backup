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
  id 1461
  arrival_time 30631.872409529762
  lifetime 236.84645261902654
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 49
    gpu 23
    rom 6
  ]
  node [
    id 1
    label "1"
    cpu 18
    gpu 17
    rom 11
  ]
  node [
    id 2
    label "2"
    cpu 5
    gpu 45
    rom 15
  ]
  node [
    id 3
    label "3"
    cpu 27
    gpu 3
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 50
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 13
  ]
]
