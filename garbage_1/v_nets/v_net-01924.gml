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
  id 1924
  arrival_time 42172.88884859442
  lifetime 101.23710871580626
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 32
    gpu 35
    rom 41
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 19
    rom 44
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 38
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 31
  ]
  edge [
    source 1
    target 2
    bw 40
  ]
]
