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
  id 319
  arrival_time 6087.415039522028
  lifetime 1616.8221844324894
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 3
    gpu 10
    rom 49
  ]
  node [
    id 1
    label "1"
    cpu 49
    gpu 3
    rom 29
  ]
  node [
    id 2
    label "2"
    cpu 32
    gpu 20
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 29
  ]
  edge [
    source 1
    target 2
    bw 22
  ]
]
