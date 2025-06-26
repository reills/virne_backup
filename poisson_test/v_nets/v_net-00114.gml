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
  id 114
  arrival_time 2133.5293131447957
  lifetime 718.0659208264815
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 0
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 42
    gpu 38
    rom 40
  ]
  node [
    id 2
    label "2"
    cpu 7
    gpu 3
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 10
    gpu 15
    rom 16
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 36
    rom 50
  ]
  node [
    id 5
    label "5"
    cpu 39
    gpu 10
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 27
  ]
  edge [
    source 1
    target 2
    bw 6
  ]
  edge [
    source 2
    target 3
    bw 9
  ]
  edge [
    source 3
    target 4
    bw 43
  ]
  edge [
    source 4
    target 5
    bw 21
  ]
]
