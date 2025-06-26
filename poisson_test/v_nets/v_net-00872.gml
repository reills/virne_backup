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
  id 872
  arrival_time 18137.45216512396
  lifetime 622.9821504054231
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 16
    gpu 34
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 16
    gpu 3
    rom 40
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 32
    rom 23
  ]
  node [
    id 3
    label "3"
    cpu 44
    gpu 40
    rom 13
  ]
  node [
    id 4
    label "4"
    cpu 25
    gpu 8
    rom 46
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 40
  ]
  edge [
    source 3
    target 4
    bw 25
  ]
]
